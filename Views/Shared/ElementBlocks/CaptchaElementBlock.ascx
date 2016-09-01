<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ control language="C#" inherits="ViewUserControl<CaptchaElementBlock>" %>

<%  var formElement = Model.FormElement; 
    var labelText = Model.Label; %>

<div class="Form__Element FormCaptcha form-group row" data-epiforms-element-name="<%: formElement.ElementName %>">
    <label class="Form__Element__Caption col-sm-3 control-label" for="<%: formElement.Guid %>">
        <%: labelText %>
    </label>
    <div class="col-sm-9">
        <img src="<%: Model.CaptchaImageHandler %>" class="FormCaptcha__Image" />
        <button name="submit" type="submit" data-epiforms-captcha-image-handler="<%: formElement.Guid %>" value="<%: SubmitButtonType.RefreshCaptcha.ToString() %>"
            class="FormExcludeDataRebind FormCaptcha__Refresh btn btn-sm">
            <%: Html.Translate("/episerver/forms/viewmode/refreshcaptcha")%>
        </button>
        <input id="<%: formElement.Guid %>" name="<%: formElement.ElementName %>" type="text" class="FormTextbox__Input FormCaptcha__Input FormHideInSummarized form-control" 
            placeholder="<%:Model.Description %>" style="width: auto;" />
        <span data-epiforms-linked-name="<%: formElement.ElementName %>" class="Form__Element__ValidationError" style="display: none;">*</span>

    </div>
</div>

<style>
    
.EPiServerForms .FormCaptcha button {
    margin-bottom: 5px;
}

.EPiServerForms .FormCaptcha img {
    margin-bottom: 5px;
}
</style>
