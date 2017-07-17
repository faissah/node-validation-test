package org.jahia.services.nodevalidationtest.decorator;

import org.hibernate.validator.constraints.Email;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.decorator.validation.JCRNodeValidator;
import org.jahia.services.nodevalidationtest.validation.FieldMatch;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@FieldMatch.List({
        @FieldMatch(first = "password", second = "confirmPassword", propertyName = "confirmPassword"),
        @FieldMatch(first = "email", second = "confirmEmail", propertyName = "confirmEmail")
})
public class UserInfoNodeValidator implements JCRNodeValidator {

    private JCRNodeWrapper node;

    public UserInfoNodeValidator(JCRNodeWrapper node) {
        this.node = node;
    }

    @NotNull
    @Size(min=8, max=25)
    public String getPassword(){
        return node.getPropertyAsString("password");
    }

    @NotNull
    @Size(min=8, max=25)
    public String getConfirmPassword() {
        return node.getPropertyAsString("confirmPassword");
    }

    @NotNull
    @Email
    public String getEmail() {
        return node.getPropertyAsString("email");
    }

    @NotNull
    @Email
    public String getConfirmEmail() {
        return node.getPropertyAsString("confirmEmail");
    }

    @NotNull
    @Size(min=1, max=10)
    public String getTranslatedProp() {
        return node.getPropertyAsString("translatedProp");
    }

}
