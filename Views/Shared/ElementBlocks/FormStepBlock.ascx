<%@ Import Namespace="System.Web.Mvc" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Forms" %>
<%@ Import Namespace="EPiServer.Forms.Core" %>
<%@ Import Namespace="EPiServer.Forms.EditView" %>
<%@ Import Namespace="EPiServer.Forms.Core.Models" %>
<%@ Import Namespace="EPiServer.Forms.Implementation.Elements" %>
<%@ Control Language="C#" Inherits="ViewUserControl<FormStepBlock>" %>

<% 
    var isViewModeInvisibleElement = Model is IViewModeInvisibleElement;
    var extraCSSClass = isViewModeInvisibleElement ? ConstantsFormsUI.CSS_InvisibleElement : string.Empty;

    if (EPiServer.Editor.PageEditing.PageIsInEditMode) { %>
        <section class="Form__Element FormStep Form__Element--NonData <%:extraCSSClass %>">
            <h3 class="FormStep__Title  "><%: Model.EditViewFriendlyTitle %></h3>
            <aside class="FormStep__Description"><%: Model.Description %></aside>
        </section>
<%  } else { %>
        <div class="form-group form-group-lg row">
            <label class="FormStep__Title2 col-sm-3 control-label"><%: Model.Label %></label>
            <div class="col-sm-9" style="margin-top: 15px;">
                <span class="FormStep__Description"><%: Model.Description %></span>
            </div>
        </div>
<%  } %>
