<%@ include file="/WEB-INF/view/common/commonTag.jsp"%>
<div>
  <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_DSP')">
    <div style="margin-bottom:30px;">
      <h3 style="margin-bottom:10px;">iClick Ad Exchange Specifications</h3>
      <div>
        <span style="margin-right:10px;">iClick Ad Exchange Specifications v1.5:</span>
        <a href="${static_path}/docs/dsp/iClick Ad Exchange Specifications v1.5.doc" target="_blank" style="font-size:20px;">
          <i class="glyphicon glyphicon-save-file" style="color:#e83829;"></i>
        </a>
      </div>
    </div>
  </sec:authorize>

  <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_PUBLISHER')">
    <div>
      <h3 style="margin-bottom:10px;">iClick Ad Exchange Seller API Specifications</h3>
      <div>
        <span style="margin-right:10px;">iClick Ad Exchange Seller API Specifications v1.5:</span>
        <a href="${static_path}/docs/publisher/iClick Ad Exchange Seller API Specifications v1.5.doc" target="_blank" style="font-size:20px;">
          <i class="glyphicon glyphicon-save-file" style="color:#e83829;"></i>
        </a>
      </div>
    </div>
  </sec:authorize>
</div>