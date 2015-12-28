package accp.scurity.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;

import org.springframework.security.access.event.AuthenticationCredentialsNotFoundEvent;
import org.springframework.security.access.event.AuthorizationFailureEvent;
import org.springframework.security.access.event.AuthorizedEvent;
import org.springframework.security.access.event.PublicInvocationEvent;
import org.springframework.security.authentication.event.AbstractAuthenticationEvent;
import org.springframework.security.authentication.event.AbstractAuthenticationFailureEvent;

import org.springframework.util.ClassUtils;


// TODO org.springframework.security.acls.domain.AuditLogger
public class AuditListener implements ApplicationListener {
    private static final Log logger = LogFactory.getLog(AuditListener.class);

    public void onApplicationEvent(ApplicationEvent event) {
        // authorization
        if (event instanceof AuthenticationCredentialsNotFoundEvent) {
            AuthenticationCredentialsNotFoundEvent authEvent = (AuthenticationCredentialsNotFoundEvent) event;

            if (logger.isWarnEnabled()) {
                logger.warn("Security interception failed due to: "
                    + authEvent.getCredentialsNotFoundException()
                    + "; secure object: " + authEvent.getSource()
                    + "; configuration attributes: "
                    + authEvent.getConfigAttributes());
            }
        }

        if (event instanceof AuthorizationFailureEvent) {
            AuthorizationFailureEvent authEvent = (AuthorizationFailureEvent) event;

            if (logger.isWarnEnabled()) {
                logger.warn("Security authorization failed due to: "
                    + authEvent.getAccessDeniedException()
                    + "; authenticated principal: "
                    + authEvent.getAuthentication() + "; secure object: "
                    + authEvent.getSource()
                    + "; configuration attributes: "
                    + authEvent.getConfigAttributes());
            }
        }

        if (event instanceof AuthorizedEvent) {
            AuthorizedEvent authEvent = (AuthorizedEvent) event;

            if (logger.isInfoEnabled()) {
                logger.info(
                    "Security authorized for authenticated principal: "
                    + authEvent.getAuthentication() + "; secure object: "
                    + authEvent.getSource()
                    + "; configuration attributes: "
                    + authEvent.getConfigAttributes());
            }
        }

        if (event instanceof PublicInvocationEvent) {
            PublicInvocationEvent authEvent = (PublicInvocationEvent) event;

            if (logger.isInfoEnabled()) {
                logger.info(
                    "Security interception not required for public secure object: "
                    + authEvent.getSource());
            }
        }

        // authentication
        if (event instanceof AbstractAuthenticationEvent) {
            AbstractAuthenticationEvent authEvent = (AbstractAuthenticationEvent) event;

            if (logger.isWarnEnabled()) {
                String message = "Authentication event "
                    + ClassUtils.getShortName(authEvent.getClass()) + ": "
                    + authEvent.getAuthentication().getName()
                    + "; details: "
                    + authEvent.getAuthentication().getDetails();

                if (event instanceof AbstractAuthenticationFailureEvent) {
                    message = message + "; exception: "
                        + ((AbstractAuthenticationFailureEvent) event).getException()
                           .getMessage();
                }

                logger.warn(message);
            }
        }
    }
}
