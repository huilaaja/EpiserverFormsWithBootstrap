﻿<%@ Import Namespace="System.Web.Mvc" %>
<%@ Import Namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms" %>
<%@ Import Namespace="EPiServer.Forms.Core.Models" %>
<%@ Import Namespace="EPiServer.Forms.Helpers.Internal" %>
<%@ import namespace="EPiServer.Forms.EditView.Internal" %>
<%@ Import Namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ Control Language="C#" Inherits="ViewUserControl<SubmitButtonElementBlock>" %>

<%
    var formElement = Model.FormElement;
    var buttonText = Model.Label;

    var buttonDisableState = Model.GetFormSubmittableStatus(ViewContext.Controller.ControllerContext.HttpContext);
%>
<div class="form-group row">
<label class="control-label col-sm-3"></label>
<div class="col-sm-9">
<button id="<%: formElement.Guid %>" name="submit" type="submit" value="<%: formElement.Guid %>" data-epiforms-is-finalized="<%: Model.FinalizeForm.ToString().ToLower() %>"
    data-epiforms-is-progressive-submit="true"
    class="Form__Element FormExcludeDataRebind FormSubmitButton btn btn-primary btn-lg"
    <%= Model.AttributesString %> <%: buttonDisableState %>
    <% if (Model.Image == null) 
    { %>
        class="Form__Element FormExcludeDataRebind FormSubmitButton">
        <span><%: buttonText %></span>
    <% } else { %>
        class="Form__Element FormExcludeDataRebind FormSubmitButton FormImageSubmitButton btn-primary btn-lg">
        <img src="<%: Model.Image.Path %>" data-epiforms-is-progressive-submit="true" data-epiforms-is-finalized="<%: Model.FinalizeForm.ToString().ToLower() %>" />
    <% } %>
</button>
</div>
</div>
