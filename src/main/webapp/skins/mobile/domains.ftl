<#include "macro-head.ftl">
<#include "macro-list.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${symphonyLabel}">
        <meta name="description" content="${symDescriptionLabel}"/>
        </@head>
    </head>
    <body>
        <#include "header.ftl">
        <div class="main">
            <div class="wrapper">
                <div class='domains-count'>
                    Domains: <b>${domainCnt}</b><br/>
                    Tags: <b>${tagCnt}</b>
                </div>
                <div class="content fn-clear">
                    <#list domains as domain>
                    <div class="module">
                        <div class="module-header">
                            <h2>${domain.domainTitle}</h2>
                            <a class="ft-gray fn-right" rel="nofollow" href="${servePath}/domain/${domain.domainURI}">${domain.domainTags?size} Tags</a>
                        </div>
                        <div class="module-panel">
                            <ul class="tags fn-clear">
                                <#list domain.domainTags as tag>
                                <li>
                                    <a class="tag" rel="nofollow" href="${servePath}/tag/${tag.tagURI}">${tag.tagTitle}</a>
                                </li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                    </#list>
                </div>
                <div class="side">
                    <#if ADLabel!="">
                    <div class="module">
                        <div class="module-header">
                            <h2>
                                ${sponsorLabel} 
                                ${wantPutOnLabel}
                            </h2>
                        </div>
                        <div class="module-panel ad fn-clear">
                            ${ADLabel}
                        </div>
                    </div>
                    </#if>
                </div>
            </div>
        </div>
        <#include "footer.ftl">
        <@listScript/>
    </body>
</html>
