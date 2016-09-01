<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Helpers.Internal" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<ChoiceElementBlock>" %>

<%
    var formElement = Model.FormElement;
    var labelText = Model.Label;
    var items = Model.GetItems();
%>

<div class="Form__Element FormChoice <%: Model.GetValidationCssClasses() %> form-group row" id="<%: formElement.Guid %>" data-epiforms-element-name="<%: formElement.ElementName %>"
    <%= Model.AttributesString %>>

    <%  if(!string.IsNullOrEmpty(labelText)) { %>
    <label class="Form__Element__Caption col-sm-3 control-label"><%: labelText %></label>
    
    <div class="col-sm-9">
    <% } 
        foreach (var item in items)
        {
            var defaultCheckedString = Model.GetDefaultSelectedString(item);
            var checkedString = string.IsNullOrEmpty(defaultCheckedString) ? string.Empty : "checked";
    %>

    <label>
        <% if(Model.AllowMultiSelect) { %>
        <input type="checkbox"  name="<%: formElement.ElementName %>" value="<%: item.Value %>" class="FormChoice__Input FormChoice__Input--Checkbox" <%: checkedString %>   <%: defaultCheckedString %> />
        <% } else  { %>
        <input type="radio"     name="<%: formElement.ElementName %>" value="<%: item.Value %>" class="FormChoice__Input FormChoice__Input--Radio"    <%: checkedString %>   <%: defaultCheckedString %> />
        <% } %>
        <%: item.Caption %></label>

    <% } %>
    <span data-epiforms-linked-name="<%: formElement.ElementName %>" class="Form__Element__ValidationError" style="display: none;">*</span>
    </div>

</div>