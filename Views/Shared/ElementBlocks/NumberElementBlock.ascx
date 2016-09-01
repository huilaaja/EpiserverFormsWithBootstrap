<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ import namespace="EPiServer.Forms" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Helpers.Internal" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<NumberElementBlock>" %>

<%  var formElement = Model.FormElement; 
    var labelText = Model.Label;
%>

<div class="Form__Element FormTextbox FormTextbox--Number <%: Model.GetValidationCssClasses() %> form-group row" data-epiforms-element-name="<%: formElement.ElementName %>" >
    <label for="<%: formElement.Guid %>" class="Form__Element__Caption col-sm-3 control-label"><%: labelText %></label>
    <div class="col-sm-9">
    <input name="<%: formElement.ElementName %>" id="<%: formElement.Guid %>" type="text" placeholder="<%: Model.PlaceHolder %>"
        class="FormTextbox__Input form-control"
        <%: Html.Raw(Model.AttributesString) %>
        value="<%: Model.GetDefaultValue() %>" />
    <span data-epiforms-linked-name="<%: formElement.ElementName %>" class="Form__Element__ValidationError" style="display: none;">*</span>
    <%= Model.RenderDataList() %>
    </div>
</div>