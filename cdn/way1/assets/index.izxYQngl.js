(function(){const n=document.createElement("link").relList;if(n&&n.supports&&n.supports("modulepreload"))return;for(const t of document.querySelectorAll('link[rel="modulepreload"]'))o(t);new MutationObserver(t=>{for(const i of t)if(i.type==="childList")for(const d of i.addedNodes)d.tagName==="LINK"&&d.rel==="modulepreload"&&o(d)}).observe(document,{childList:!0,subtree:!0});function r(t){const i={};return t.integrity&&(i.integrity=t.integrity),t.referrerPolicy&&(i.referrerPolicy=t.referrerPolicy),t.crossOrigin==="use-credentials"?i.credentials="include":t.crossOrigin==="anonymous"?i.credentials="omit":i.credentials="same-origin",i}function o(t){if(t.ep)return;t.ep=!0;const i=r(t);fetch(t.href,i)}})();function v(e){var o,t;const n={source:"kbbuddy-mini-app",...e},r=JSON.stringify(n);if(window.parent&&window.parent!==window&&window.parent.postMessage(n,"*"),(o=window.ReactNativeWebView)!=null&&o.postMessage){window.ReactNativeWebView.postMessage(r);return}if((t=window.fromWeb2Native)!=null&&t.postMessage){window.fromWeb2Native.postMessage(r);return}console.info("[KBBuddyMiniApp → Host]",n)}function T(){return{isMock:!1,emit(e,n={}){v({version:"1.0",type:"event",event:e,...n,timestamp:Date.now()})},async invoke(e,n={}){return v({version:"1.0",type:"capability_request",capability:e,args:n}),{}}}}function k(){return{isMock:!0,emit(e,n){console.info(`[MockHost] ${e}`,n??{})},async invoke(e,n){return console.info(`[MockHost] invoke ${e}`,n??{}),e==="api.regAccount"?(await M(600),{success:!0,requestId:`MOCK-${Date.now()}`}):{}}}}function M(e){return new Promise(n=>setTimeout(n,e))}const g={pageTitle:"Đăng ký mở tài khoản",headerBadge:"KB Securities × KBBuddy",headerTitle:"Mở tài khoản chứng khoán trực tuyến",headerSubtitle:"Hoàn tất trong vài phút — chuẩn bị CMND/CCCD và SĐT nhận OTP",investorType:"1. Quý khách là nhà đầu tư? (*)",investorIndividualVn:"Cá nhân - Việt Nam",investorOrgVn:"Tổ chức - Việt Nam",investorIndividualForeign:"Cá nhân - Nước ngoài",investorOrgForeign:"Tổ chức - Nước ngoài",fullName:"2. Tên cá nhân/ tổ chức",fullNamePlaceholder:"Nhập tên cá nhân/ tổ chức",phone:"3. Số điện thoại (*)",phonePlaceholder:"Nhập số điện thoại",referrer:"4. Mã môi giới / Số TKCK người giới thiệu",referrerPlaceholder:"Nhập mã môi giới hoặc số TKCK",accountModel:"5. Chọn mô hình quản lý tài khoản",selfTrading:"Khách hàng chủ động giao dịch",brokerAdvised:"Khách hàng có nhân viên môi giới tư vấn",branch:"6. Chọn Chi nhánh / Phòng giao dịch (*)",branchPlaceholder:"Chọn chi nhánh",branchHcm:"Chi nhánh TP. Hồ Chí Minh",branchHn:"Chi nhánh Hà Nội",branchDn:"Chi nhánh Đà Nẵng",next:"Tiếp theo",phoneInvalid:"Số điện thoại phải có ít nhất 10 chữ số",nameRequired:"Vui lòng nhập tên",branchRequired:"Vui lòng chọn chi nhánh",successTitle:"Đăng ký thành công",successMessage:"KBSV đã tiếp nhận thông tin đăng ký mở tài khoản. Chúng tôi sẽ liên hệ trong thời gian sớm nhất.",hotline:"Hotline: 1900 1711"},w={pageTitle:"Account Registration",headerBadge:"KB Securities × KBBuddy",headerTitle:"Open securities account online",headerSubtitle:"Complete in minutes — prepare ID card and phone for OTP",investorType:"1. Investor type (*)",investorIndividualVn:"Individual - Vietnam",investorOrgVn:"Organization - Vietnam",investorIndividualForeign:"Individual - Foreign",investorOrgForeign:"Organization - Foreign",fullName:"2. Full name / Organization",fullNamePlaceholder:"Enter full name",phone:"3. Phone number (*)",phonePlaceholder:"Enter phone number",referrer:"4. Broker / Referrer account",referrerPlaceholder:"Broker code or account number",accountModel:"5. Account management model",selfTrading:"Self-directed trading",brokerAdvised:"Broker-advised account",branch:"6. Branch / Transaction office (*)",branchPlaceholder:"Select branch",branchHcm:"Ho Chi Minh City Branch",branchHn:"Hanoi Branch",branchDn:"Da Nang Branch",next:"Next",phoneInvalid:"Phone must be at least 10 digits",nameRequired:"Please enter your name",branchRequired:"Please select a branch",successTitle:"Registration submitted",successMessage:"We have received your account opening request and will contact you soon.",hotline:"Hotline: 1900 1711"},S=g,P={vi:g,en:w,ko:S};function C(e){return P[e]??g}function E(e){return e==="en"||e==="ko"||e==="vi"?e:"vi"}const O=["0001","0002","0003","0004"];function B(e,n){return{"0001":e.investorIndividualVn,"0002":e.investorOrgVn,"0003":e.investorIndividualForeign,"0004":e.investorOrgForeign}[n]}function I(e){return[{value:"HCM",label:e.branchHcm},{value:"HN",label:e.branchHn},{value:"DN",label:e.branchDn}]}function H(e){return e.replace(/\D/g,"").slice(0,11)}function _(e,n){const r={};return e.fullName.trim()||(r.fullName=n.nameRequired),e.phone.length<10&&(r.phone=n.phoneInvalid),e.branch||(r.branch=n.branchRequired),r}function D(e){return e.phone.length>=10}function b(e,n){const r=C(n.locale),o={investorType:"0001",fullName:"",phone:"",referrer:"",accountModel:"self",branch:""};let t={},i=!1,d=!1;n.bridge.emit("JOURNEY_STARTED",{module:"register"});function c(){const s=I(r),l=n.isDev?" register-page--dev":"";e.innerHTML=`
      ${n.isDev?'<div class="dev-banner">DEV · Mock bridge · mini-app/webview-cdn</div>':""}
      <div class="register-page${l}">
        <header class="register-header">
          <span class="register-header__badge">${r.headerBadge}</span>
          <h1 class="register-header__title">${r.headerTitle}</h1>
          <p class="register-header__subtitle">${r.headerSubtitle}</p>
        </header>

        <main class="register-body">
          <section class="register-section">
            <label class="register-label">${r.investorType}</label>
            <div class="chip-group" role="radiogroup" aria-label="${r.investorType}">
              ${O.map(a=>`
                <button type="button" class="chip${o.investorType===a?" chip--active":""}"
                  data-investor="${a}" aria-pressed="${o.investorType===a}">
                  ${B(r,a)}
                </button>`).join("")}
            </div>
          </section>

          <section class="register-section">
            <label class="register-label" for="fullName">${r.fullName}</label>
            <input id="fullName" class="field-input${t.fullName?" field-input--error":""}"
              type="text" autocomplete="name" placeholder="${r.fullNamePlaceholder}"
              value="${p(o.fullName)}" />
            ${t.fullName?`<p class="field-error">${t.fullName}</p>`:""}
          </section>

          <section class="register-section">
            <label class="register-label" for="phone">${r.phone}</label>
            <input id="phone" class="field-input${t.phone?" field-input--error":""}"
              type="tel" inputmode="numeric" autocomplete="tel"
              placeholder="${r.phonePlaceholder}" value="${p(o.phone)}" />
            ${t.phone?`<p class="field-error">${t.phone}</p>`:""}
          </section>

          <section class="register-section">
            <label class="register-label register-label--optional" for="referrer">${r.referrer}</label>
            <input id="referrer" class="field-input" type="text"
              placeholder="${r.referrerPlaceholder}" value="${p(o.referrer)}" />
          </section>

          <section class="register-section">
            <span class="register-label">${r.accountModel}</span>
            <div class="radio-group" role="radiogroup">
              <label class="radio-card${o.accountModel==="self"?" radio-card--active":""}">
                <input type="radio" name="accountModel" value="self" ${o.accountModel==="self"?"checked":""} />
                <span class="radio-card__text">${r.selfTrading}</span>
              </label>
              <label class="radio-card${o.accountModel==="broker"?" radio-card--active":""}">
                <input type="radio" name="accountModel" value="broker" ${o.accountModel==="broker"?"checked":""} />
                <span class="radio-card__text">${r.brokerAdvised}</span>
              </label>
            </div>
          </section>

          <section class="register-section">
            <label class="register-label" for="branch">${r.branch}</label>
            <select id="branch" class="field-select${t.branch?" field-select--error":""}">
              <option value="">${r.branchPlaceholder}</option>
              ${s.map(a=>`<option value="${a.value}"${o.branch===a.value?" selected":""}>${a.label}</option>`).join("")}
            </select>
            ${t.branch?`<p class="field-error">${t.branch}</p>`:""}
          </section>
        </main>

        <footer class="register-footer">
          <button type="button" id="btnNext" class="btn-primary${i?" btn-primary--loading":""}"
            ${!D(o)||i?"disabled":""}>
            ${r.next}
          </button>
        </footer>
      </div>

      ${d?`
      <div class="success-overlay" role="dialog" aria-modal="true">
        <div class="success-dialog">
          <div class="success-dialog__icon" aria-hidden="true">✓</div>
          <h2 class="success-dialog__title">${r.successTitle}</h2>
          <p class="success-dialog__message">${r.successMessage}</p>
          <p class="success-dialog__hotline">${r.hotline}</p>
          <button type="button" id="btnCloseSuccess" class="btn-primary">${r.next}</button>
        </div>
      </div>`:""}
    `,$()}function $(){var f,m;e.querySelectorAll("[data-investor]").forEach(u=>{u.addEventListener("click",()=>{o.investorType=u.dataset.investor,c()})});const s=e.querySelector("#fullName");s==null||s.addEventListener("input",()=>{o.fullName=s.value,delete t.fullName});const l=e.querySelector("#phone");l==null||l.addEventListener("input",()=>{o.phone=H(l.value),l.value=o.phone,delete t.phone,c()});const a=e.querySelector("#referrer");a==null||a.addEventListener("input",()=>{o.referrer=a.value.toUpperCase(),a.value=o.referrer}),e.querySelectorAll('input[name="accountModel"]').forEach(u=>{u.addEventListener("change",()=>{o.accountModel=u.value,c()})});const h=e.querySelector("#branch");h==null||h.addEventListener("change",()=>{o.branch=h.value,delete t.branch,c()}),(f=e.querySelector("#btnNext"))==null||f.addEventListener("click",N),(m=e.querySelector("#btnCloseSuccess"))==null||m.addEventListener("click",()=>{d=!1,c()})}async function N(){if(t=_(o,r),Object.keys(t).length>0){c();return}i=!0,c();const s={typeinvestor:o.investorType,fullname:o.fullName.trim(),mobile:o.phone,refcustodycd:o.referrer.trim(),typeacct:o.accountModel==="broker"?"1":"0",branch:o.branch};try{await n.bridge.invoke("api.regAccount",s),n.bridge.emit("REGISTRATION_SUBMITTED",s),d=!0}catch(l){n.bridge.emit("JOURNEY_FAILED",{error:String(l)})}finally{i=!1,c()}}document.title=r.pageTitle,c()}function p(e){return e.replace(/&/g,"&amp;").replace(/"/g,"&quot;").replace(/</g,"&lt;")}function q(){const e=new URLSearchParams(window.location.search),n=e.get("module")??"register",r=e.get("mock")!=="0"&&!1;return{module:n,locale:E(e.get("locale")),partnerId:e.get("partnerId")??void 0,sessionToken:e.get("sessionToken")??void 0,mock:r}}function R(e){const n=q(),r=n.mock?k():T();switch(window.KBBuddyHost=r,r.emit("READY",{module:n.module,locale:n.locale,partnerId:n.partnerId,version:"0.1.0"}),n.module){case"register":b(e,{locale:n.locale,bridge:r,isDev:n.mock});break;case"ekyc":case"order":e.innerHTML=`
        <div style="padding:24px;font-family:system-ui;text-align:center;color:#696e76">
          <p>Module <strong>${n.module}</strong> — coming soon</p>
          <p style="font-size:13px">Dùng <code>?module=register</code> để xem màn đăng ký</p>
        </div>`;break;default:b(e,{locale:n.locale,bridge:r,isDev:n.mock})}}const y=document.getElementById("app");if(!y)throw new Error("#app not found");R(y);
