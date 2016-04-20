<%@ Import Namespace="System.Web.Mvc" %>
<%@ Import Namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms.Core.Models" %>
<%@ Import Namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ Control Language="C#" Inherits="ViewUserControl<ResetButtonElementBlock>" %>

<%  var formElement = Model.FormElement; 
    var buttonText = Model.Label; %>

<div class="form-group row">
<label class="control-label col-sm-3"></label>
<div class="col-sm-9">
<input  
    <%--name="<%: formElement.ElementName %>" id="<%: formElement.Guid %>" --%>
    type="reset" form="<%: Model.FormElement.Form.FormGuid %>"
    class="Form__Element FormResetButton Form__Element--NonData btn btn-sm" <%: Html.Raw(Model.AttributesString) %>
    value="<%: buttonText %>" >
</div>
</div>