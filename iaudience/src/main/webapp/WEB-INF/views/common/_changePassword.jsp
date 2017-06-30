<!-- Page title -->
<div class="page_title">
  <div id="breadcrumb" class="row">
    <!-- Top left headings and links -->
    <div class="client-row"></div>
  </div>

  <div class="row">
    <div class="client-row">
      <h1>
        <s:message code="menu.desc.accounts.change.password"/>
      </h1>
    </div>
  </div>
</div>

<!-- form -->
<div class="edit-container">
  <form class="form-horizontal" id="modifyForm" action="${path}/${role}/accounts/changePassword" method="post">
    <input type="hidden" name="_method" value="PUT"/>
          
    <div class="control-group">
      <label class="control-label"><s:message code="accounts.change.password.old.password"/></label>
      <div class="controls">
        <div class="clearfix">
          <input type="password" name="oldPassword"/>
        </div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label"><s:message code="accounts.change.password.new.password"/></label>
      <div class="controls">
        <div class="clearfix">
          <input id="newPassword" type="password" name="newPassword"/>
        </div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label"><s:message code="accounts.change.password.new.password.confirm"/></label>
      <div class="controls">
        <div class="clearfix modifylabel">
          <input type="password" name="newPasswordConfirm"/>
        </div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>

    <div class="control-group">
      <button type="button" class="btn btn-success" onclick="$('form').submit();">
        <s:message code="common.save"/>
      </button>
    </div>
  </form>
</div>

<script type="text/javascript">
  $(function() {
    $("form").validate({
      rules:{
        "oldPassword": {
          required: true,
          minlength: 6
        },
        "newPassword": {
          required: true,
          minlength: 6
        },
        "newPasswordConfirm": {
          required: true,
          minlength: 6,
          equalTo: "#newPassword"
        }
      },
      errorPlacement: function(error, element) { 
        element.parents(".controls").find(".error-message").removeClass("hide");
        error.appendTo(element.parents(".controls").find(".error-message").find(".clearfix")); 
      },
      messages: {
        "oldPassword": {
          required: "<s:message code='form.error.user.password.empty'/>",
          minlength: jQuery.format("<s:message code='form.error.user.password.range'/>")
        },
        "newPassword": {
          required: "<s:message code='form.error.user.password.empty'/>",
          minlength: jQuery.format("<s:message code='form.error.user.password.range'/>")
        },
        "newPasswordConfirm": {
          required: "<s:message code='form.error.user.password.empty'/>",
          minlength: jQuery.format("<s:message code='form.error.user.password.range'/>"),
          equalTo: "<s:message code='form.error.user.password.equal'/>"
        }
      },
      success: function(label) {
        $(label).parents(".error-message").addClass("hide");
      },
      submitHandler: function(form) {
        $('[type="button"]').attr("disabled", true);
        form.submit();  
      },
      invalidHandler: function(form, validator) {
        $("label.error").parent().parent().removeClass("hide");
        return false; 
      }
    });
  });
</script>