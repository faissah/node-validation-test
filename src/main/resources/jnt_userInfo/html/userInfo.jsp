<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<template:addResources type="javascript" resources="jquery.min.js"/>
<template:addResources type="css" resources="node-validation-test.css"/>
<template:addResources>
<script type="text/javascript">
    $(document).ready(function () {
        $("#delete${currentNode.name}").click(function () {
            $.post('<c:url value='${url.base}${currentNode.path}'/>',
                    {jcrMethodToCall: "delete", jcrRedirectTo: "<c:url value='${url.base}${renderContext.mainResource.node.path}'/>", jcrNewNodeOutputFormat: "html"},
                    function (result) {
                        location.reload(true);
                    }, "json");
        });

        $("#updateForm_${currentNode.identifier}").submit(function(event) {
            event.preventDefault();
            var $form = $(this);
            var url = $form.attr('action');
            var type = $form.attr('method');
            var values = $form.serializeArray();
            $.ajax({
                type : type,
                url: url,
                data: values,
                dataType: "json",
                success: function(data, textStatus, jqXHR) {
                    location.reload();
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    if (jqXHR.status == 400) {
                        var json = $.parseJSON(jqXHR.responseText);
                        if (typeof(json.validationError) !== "undefined") {
                            var validationError = json.validationError;
                            $(".validationError").text("");
                            for (var i = 0; i < validationError.length; i++) {
                                var valErr = validationError[i];
                                $("#" + valErr.propertyName + "Error_${currentNode.identifier}").text(valErr.constraintMessage);
                            }
                        }
                    }
                }
            });
            return false;
        });
    });
</script>
</template:addResources>

<form class="Form userInfoFormEdition" method="post"
      action="<c:url value='${url.base}${currentNode.path}'/>"
      id="updateForm_${currentNode.identifier}">
    <input type="hidden" name="jcrNodeType" value="jnt:userInfo">
    <input type="hidden" name="jcrMethodToCall" value="put"/>
    <input type="hidden" name="jcrRedirectTo" value="<c:url value='${url.base}${renderContext.mainResource.node.path}'/>"/>
    <input type="hidden" name="jcrNewNodeOutputFormat" value="html"/>
    <p>
        <label for="password_${currentNode.identifier}"><fmt:message key="jnt_userInfo.password"/></label>
        <input type="text" name="password" id="password_${currentNode.identifier}" class="field" value="${currentNode.properties['password'].string}" />
        <span id="passwordError_${currentNode.identifier}" class="validationError"></span>
    </p>
    <p>
        <label for="confirmPassword_${currentNode.identifier}"><fmt:message key="jnt_userInfo.confirmPassword"/></label>
        <input type="text" name="confirmPassword" id="confirmPassword_${currentNode.identifier}" class="field" value="${currentNode.properties['confirmPassword'].string}" />
        <span id="confirmPasswordError_${currentNode.identifier}" class="validationError"></span>
    </p>
    <p>
        <label for="email_${currentNode.identifier}"><fmt:message key="jnt_userInfo.email"/></label>
        <input type="text" name="email" id="email_${currentNode.identifier}" class="field" value="${currentNode.properties['email'].string}" />
        <span id="emailError_${currentNode.identifier}" class="validationError"></span>
    </p>
    <p>
        <label for="confirmEmail_${currentNode.identifier}"><fmt:message key="jnt_userInfo.confirmEmail"/></label>
        <input type="text" name="confirmEmail" id="confirmEmail_${currentNode.identifier}" class="field" value="${currentNode.properties['confirmEmail'].string}" />
        <span id="confirmEmailError_${currentNode.identifier}" class="validationError"></span>
    </p>
    <p>
        <label for="translatedProp_${currentNode.identifier}"><fmt:message key="jnt_userInfo.translatedProp"/></label>
        <input type="text" name="translatedProp" id="translatedProp_${currentNode.identifier}" class="field" value="${currentNode.properties['translatedProp'].string}" />
        <span id="translatedPropError_${currentNode.identifier}" class="validationError"></span>
    </p>
    <div>
        <input id="editUserInfo${currentNode.name}" type="submit" class="button" value="OK" tabindex="23" />
        <input type="button" class="button" value="Delete" tabindex="24" id="delete${currentNode.name}" />
    </div>
</form>
