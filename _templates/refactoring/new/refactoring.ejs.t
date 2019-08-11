---
to: src/refactorings/<%= h.changeCase.param(name) %>/<%= h.changeCase.param(name) %>.ts
---
<%
  camelName = h.changeCase.camel(name)
  camelActionProviderName = h.changeCase.camel(actionProviderName)
  pascalErrorName = h.changeCase.pascalCase(errorReason.name)
-%>
import { Code, Write } from "../../editor/i-write-code";
import { Selection } from "../../editor/selection";
import {
  ShowErrorMessage,
  ErrorReason
} from "../../editor/i-show-error-message";
import * as ast from "../../ast";

<% if (hasActionProvider){ -%>
export { <%= camelName %>, <%= camelActionProviderName %> };
<% } else { -%>
export { <%= camelName %> };
<% } -%>

async function <%= camelName %>(
  code: Code,
  selection: Selection,
  write: Write,
  showErrorMessage: ShowErrorMessage
) {
  const updatedCode = updateCode(code, selection);

  if (!updatedCode.hasCodeChanged) {
    showErrorMessage(ErrorReason.<%= pascalErrorName %>);
    return;
  }

  await write(updatedCode.code);
}

<% if (hasActionProvider){ -%>
function <%= camelActionProviderName %>(code: Code, selection: Selection): boolean {
  return updateCode(code, selection).hasCodeChanged;
}
<% } -%>

function updateCode(code: Code, selection: Selection): ast.Transformed {
  return ast.transform(code, {
    // TODO: implement the transformation here 🧙‍
  });
}
