﻿<%@ import namespace="System.Web.Mvc" %>
<%@ import namespace="EPiServer.Core" %>
<%@ import namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms" %>
<%@ Import Namespace="EPiServer.Forms.Configuration" %>
<%@ import namespace="EPiServer.Forms.Core" %>
<%@ import namespace="EPiServer.Forms.Core.Models" %>
<%@ import namespace="EPiServer.Forms.Helpers.Internal" %>
<%@ import namespace="EPiServer.Forms.EditView.Internal" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ import namespace="EPiServer.Forms.Implementation.Elements.BaseClasses" %>
<%@ control language="C#" inherits="ViewUserControl<FormContainerBlock>" %>

<%  
    var _formConfig = EPiServer.ServiceLocation.ServiceLocator.Current.GetInstance<EPiServer.Forms.Configuration.IEPiServerFormsImplementationConfig>();
%>


<% if (EPiServer.Editor.PageEditing.PageIsInEditMode) { %>
<link rel="stylesheet" type="text/css" data-epiforms-resource="EPiServerForms.css" href='<%: ModuleHelper.ToClientResource(typeof(FormsModule), "ClientResources/ViewMode/EPiServerForms.css")%>' />
    <% if (Model.Form != null) { %>
<div class="EPiServerForms">
    <h2 class="Form__Title"><%: Html.PropertyFor(m => m.Title) %></h2>
    <h4 class="Form__Description"><%: Html.PropertyFor(m => m.Description) %></h4>

    <%: Html.PropertyFor(m => m.ElementsArea) %>
</div>
<% } else { %>
        <%--In case FormContainerBlock is used as a property, we cannot build Form model so we show a warning message to notify user--%>
        <div class="EPiServerForms">
            <span class="Form__Warning"><%: Html.Translate("/episerver/forms/editview/cannotbuildformmodel") %></span>
        </div>
    <% } %>
<% } else if (Model.Form != null) { %>

<%-- 
    Using form tag (instead of div) for the sake of html elements' built-in features e.g. reset, file upload
    Using enctype="multipart/form-data" for post data and uploading files 
--%>
<%
    var validationFailCssClass = ViewBag.ValidationFail ? "ValidationFail" : string.Empty;
%>
<%--Form will post to its own page Controller --%>

<form method="post" 
    enctype="multipart/form-data" class="EPiServerForms form-horizontal <%: validationFailCssClass %>" data-epiforms-type="form" id="<%: Model.Form.FormGuid %>">
    <%--Meta data, authoring data of this form is transfer to clientside here. We need to take form with language coresponse with current page's language --%>
    <script type="text/javascript" src="<%: _formConfig.CoreController %>/GetFormInitScript?formGuid=<%: Model.Form.FormGuid %>&formLanguage=<%: FormsExtensions.GetCurrentPageLanguage() %>"></script>

    <%--Meta data, send along as a SYSTEM information about this form, so this can work without JS --%>
    <input type="hidden" class="Form__Element Form__SystemElement FormHidden FormHideInSummarized" name="__FormGuid"                value="<%: Model.Form.FormGuid %>" />
    <input type="hidden" class="Form__Element Form__SystemElement FormHidden FormHideInSummarized" name="__FormHostedPage"          value="<%: FormsExtensions.GetCurrentPageLink().ToString() %>" />
    <input type="hidden" class="Form__Element Form__SystemElement FormHidden FormHideInSummarized" name="__FormLanguage"            value="<%: FormsExtensions.GetCurrentPageLanguage() %>" />
    <input type="hidden" class="Form__Element Form__SystemElement FormHidden FormHideInSummarized" name="__FormCurrentStepIndex"    value="<%: ViewBag.CurrentStepIndex ?? "" %>" />
    <input type="hidden" class="Form__Element Form__SystemElement FormHidden FormHideInSummarized" name="__FormSubmissionId"        value="<%: ViewBag.FormSubmissionId %>" />
    
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-10">
                <h2 class="Form__Title"><%: Model.Title %></h2>
                <aside class="Form__Description"><%: Model.Description %></aside>
            </div>
    </div>

    <%  var statusDisplay = "hide";
        var message = ViewBag.Message;

        if (ViewBag.FormFinalized || ViewBag.IsProgressiveSubmit){
            statusDisplay = "Form__Success__Message";
        }
        else if (!ViewBag.Submittable || ViewBag.ValidationFail) {
            statusDisplay = "Form__Warning__Message";
        } 
    %>
    <%
       if (ViewBag.IsReadOnlyMode)
       {
        %>
            <div class="Form__Status">
                <span class="Form__Readonly__Message">
                    <%: Html.Translate("/episerver/forms/viewmode/readonlymode")%>
                </span>
            </div>
        <% 
       }
    %>

    <%-- area for showing Form's status or validation --%>

    <div class="row">
        <div class="col-md-2"></div>
        <div class="Form__Status col-md-10">
            <span class="Form__Status__Message <%: statusDisplay %> alert">
                <% if (ViewBag.FormFinalized)
                    { %>
                <%= message %>
                <% }
                else
                { %>
                <%: message %>
                <% } %>
            </span>
        </div>
    </div>

    <div class="Form__MainBody">
        <%  var i = 0;
            var currentStepIndex = ViewBag.CurrentStepIndex == null ? -1 : (int)ViewBag.CurrentStepIndex;
            string stepDisplaying;
            foreach (var step in Model.Form.Steps) { 
                stepDisplaying = (currentStepIndex == i && !ViewBag.FormFinalized && (bool)ViewBag.IsStepValidToDisplay) ? "" : "hide"; %>
        <section id="<%: step.ElementName %>" data-epiforms-element-name="<%: step.ElementName %>" class="Form__Element FormStep Form__Element--NonData <%: stepDisplaying %>" data-epiforms-stepindex="<%: i %>">
            <% 
                var stepBlock = (step.SourceContent as ElementBlockBase);
                if(stepBlock != null)
                {
                    Html.RenderContentData(step.SourceContent, false);
                }
            %>

            <!-- Each FormStep groups the elements below it til the next FormStep -->
            <%
                Html.RenderFormElements(i, step.Elements);
            %>
        </section>

        <% i++; } // end foreach steps %>

        <% // show Next/Previous buttons when having Steps > 1 and navigationBar when currentStepIndex is valid
            var currentDisplayStepCount = Model.Form.Steps.Count();
            if (currentDisplayStepCount > 1 && currentStepIndex > -1 && currentStepIndex < currentDisplayStepCount && !ViewBag.FormFinalized) {
                string prevButtonDisableState = (currentStepIndex == 0) || !ViewBag.Submittable ? "disabled" : "";
                string nextButtonDisableState = (currentStepIndex == currentDisplayStepCount - 1) || !ViewBag.Submittable ? "disabled" : "";
        %>
        <% if (Model.ShowNavigationBar) { %>
        <div class="row">
            <nav role="navigation" class="Form__NavigationBar row">
                <div class="col-sm-3"></div>
                <div class="col-sm-9">
                    <button type="submit" name="submit" value="<%: SubmitButtonType.PreviousStep.ToString() %>" class="Form__NavigationBar__Action FormExcludeDataRebind btnPrev btn btn-secondary" <%: prevButtonDisableState %>><%: Html.Translate("/episerver/forms/viewmode/stepnavigation/previous")%></button>

                    <%
                        // calculate the progress style on-server-side
                        var currentDisplayStepIndex = currentStepIndex + 1;
                        var progressWidth = (100 * currentDisplayStepIndex / currentDisplayStepCount) + "%";
                    %>
                    <div class="Form__NavigationBar__ProgressBar">
                        <div class="Form__NavigationBar__ProgressBar--Progress" style="width: <%: progressWidth %>"></div>
                        <div class="Form__NavigationBar__ProgressBar--Text">
                            <span class="Form__NavigationBar__ProgressBar__ProgressLabel"><%: Html.Translate("/episerver/forms/viewmode/stepnavigation/page")%></span> <span class="Form__NavigationBar__ProgressBar__CurrentStep"><%:currentDisplayStepIndex %></span>/<span class="Form__NavigationBar__ProgressBar__StepsCount"><%:currentDisplayStepCount %></span>
                        </div>
                    </div>

                    <button type="submit" name="submit" value="<%: SubmitButtonType.NextStep.ToString() %>" class="Form__NavigationBar__Action FormExcludeDataRebind btnNext btn btn-secondary" <%: nextButtonDisableState %>><%: Html.Translate("/episerver/forms/viewmode/stepnavigation/next")%></button>
                </div>
            </nav>
        </div>
        <% } %>

        <% } // endof if %>
    </div>
    <%-- endof FormMainBody --%>
</form>

<style>
    
.EPiServerForms .Form__NavigationBar button.Form__NavigationBar__Action {
    display: inline-block;
    padding: 10px;
    height: auto;
    width: auto;
    max-width: 100%;
}

</style>
<% } %>