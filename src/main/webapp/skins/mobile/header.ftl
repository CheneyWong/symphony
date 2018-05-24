<div class="nav"> 
    <div class="wrapper fn-clear">
        <div class="head-fn fn-left">
            <h1>
                <a href="${servePath}" aria-label="${symphonyLabel}" style="text-decoration:none">
                    <p style="padding-top: 0.1em;color: whitesmoke;text-decoration:none">全栈工程师俱乐部</p>
                </a>
            </h1>
        </div>

        <div class="fn-right user-nav">
            <#if isLoggedIn>
            <#if permissions["menuAdmin"].permissionGrant>
            <a href="${servePath}/admin" title="${adminLabel}" class="last"><svg><use xlink:href="#userrole"></use></svg></a>
            </#if>
            <a href="${servePath}/member/${currentUser.userName}" title="Home" class="<#if 'adminRole' != userRole>last </#if>nav-avatar">
                <span class="avatar-small" style="background-image:url('${currentUser.userAvatarURL20}')"></span>
            </a>
            <a href="${servePath}/activities" title="${activityLabel}"><svg><use xlink:href="#flag"></use></svg></a>
            <#if permissions["commonAddArticle"].permissionGrant>
                <a href="${servePath}/pre-post" title="${addArticleLabel}"><svg><use xlink:href="#addfile"></use></svg></a>
            </#if>
            <a id="aNotifications" class="<#if unreadNotificationCount == 0>no-msg<#else>msg</#if>" href="${servePath}/notifications" title="${messageLabel}">${unreadNotificationCount}</a>
            <a href="${servePath}/recent"><svg><use xlink:href="#refresh"></use></svg></a>
            <#else>
                <a href="javascript: Util.goLogin();" title="${loginLabel}" class="unlogin">${loginLabel}</a>
                <a id="aRegister" href="javascript:Util.goRegister()" class="last ft-blue unlogin"
                 title="${registerLabel}">${registerLabel}</a>
            </#if>
        </div>
    </div>
</div>
