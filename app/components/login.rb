# The Login component
# Lets user type in their credentials, so they can authenticate themselves
class Login < Netzke::Base

  # Set the EXT JS class
  #js_base_class 'Ext.window.Window'
  js_base_class 'Ext.panel.Panel'
  #js_base_class 'Ext.layout.container.Border'

  #Configure the component

  #@return [Hash]
  def configuration
    super.merge(
        border: false,
        header: false,
        #resizable: true,
        hidden: false,
        auto_scroll: false,
        item_id: "login_page",
        cls: 'login-background transparent-bg',
        xtype: 'container',
        modal: true,
        border: false,
        items: [{xtype: 'panel',
                 border: false,
                 item_id: 'login_center',
                 items: [
                     {   layout: 'border',
                         region: 'center',
                         width: '100%',
                         layout: {type: 'vbox', pack: 'center', align: 'center'},
                         header: false,
                         border: false,
                         items: [
                             {   xtype: 'panel',
                                 width: 290,
                                 height: 180,
                                 padding: "15 0 25 0",
                                 border: false,
                                 layout: {type: 'fit', pack: 'center', align: 'center'},
                                 items: [{
                                             xtype: 'image',
                                             src: '/assets/login_page_top_logo_and_text.png',
                                         },]
                             },{border: false,
                                cls: "drop-shadow curved curved-hz-2",
                                style: "margin-top: 4px",
                                items: [
                                    {xtype: 'panel',
                                     layout: {type: 'vbox', align: 'center', pack: 'center'},
                                     cls: 'blue-clr',
                                     border: false,
                                     width: "40%",
                                     items: [

                                         {
                                             border: false,
                                             margin: "0 0 0 0",
                                             html: "<h3 style = 'color: #000; text-align: center; margin: 15 0 0 0;'>W E L C O M E</h3>",
                                         },

                                         {
                                             :xtype => :form,
                                             cls: 'blue-clr',
                                             item_id: 'login-form',
                                             margin: "5%, 5%, 5%, 40%",
                                             :border => false,
                                             :button_align => 'center',
                                             :buttons => [:create_user_session.action],
                                             :url => Netzke::Core.controller.new_user_session_path(:format => :json),
                                             :default_type => :textfield,
                                             :defaults => {
                                                 :allowBlank => false,
                                                 :enable_key_events => true,
                                                 :listeners => {
                                                     :special_key => <<-JS.l
                                                     function(field, e)
                                                        {

                                                          // if user presses ENTER => call onSignIn()
                                                          if(e.getKey() == Ext.EventObject.ENTER)
                                                          {
                                                           this.up('login').onCreateUserSession();
                                                          }
                                                        }
                                                     JS
                                                 }
                                             },
                                             :items => [{
                                                            :name => 'user[email]',
                                                            :field_label => User.human_attribute_name(:login),
                                                            :item_id => :user_email,
                                                            :empty_text => 'username',
                                                            :empty_class => 'empty_class',
                                                            :field_label => '',
                                                            height: 30,
                                                            width: 220,
                                                            border: false,
                                                            fieldStyle: 'background-color: #A9DDF3 !important; background-image: none;  color: black;
                                                                      webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; border:none 0px black; z-index: -1;'
                                                        },{
                                                            :name => 'user[password]',
                                                            :field_label => User.human_attribute_name(:password),
                                                            :item_id => :user_password,
                                                            :input_type => :password,
                                                            :empty_text => 'password',
                                                            :field_label => '',
                                                            height: 30,
                                                            width: 220,
                                                            fieldStyle: 'background-color: #A9DDF3 !important; background-image: none; color: black;
                                                                      webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; border:none 0px black'
                                                        }
                                             ]
                                         },{
                                             border: false,
                                             margin: "-33 0 10 0",
                                             html: "<h6 style='text-align: right;'>
                                                    <a style='text-decoration: none; color: #414144;' href= #{Netzke::Core.controller.reset_password_path}>forgot password?</a></h6>"
                                         }
                                     ]
                                    }
                                ]
                             },
                         ]
                     },{
                         width: "100%",
                         height: 220,
                         item_id: 'login_south',
                         margin: '-23 0 0 0',
                         html: '<div class="login-page-bottom-links">
                               <a href="http://www.fasternotes.com" target="_blank"><img style="" src="assets/login_page_bottom_button_home.png" width="34%" /></a>
                               <a href="http://www.fasternotes.com/support" target="_blank"><img style="" src="assets/login_page_bottom_button_support.png" width="33%"/></a>
                               <a href="http://www.fasternotes.com/request-demo" target="_blank"><img style="" src="assets/login_page_bottom_button_signup.png" width="33%"/></a>
                               </div>
                               <div style="clear:both; padding: 20px 0px 0px 0px"><a style="text-align: center; display:block; "
                                 href="#" target="_blank"><img src="/assets/login_page_bottom_links.png" usemap="#links"/></a>
                               <map name="links">
                                 <area shape="rect" coords="0,0,120,120" href="http://www.fasternotes.com/privacy-policy" target="_blank">
                                 <area shape="rect" coords="120,0,300,200" href="http://www.fasternotes.com/terms" target="_blank">
                               </map>
                               </div>',
                         border: false,
                         style: 'margin: 2% auto; display: block;'
                     }

                 ]

        }]
    )
  end

  # Sign in button
  action :create_user_session, :text => "L O G I N", :tooltip => "Click here to login", color: '414144', :form_bind => true, margin: "30px 0px 0px 0px", width: 120, height: 36
  #:icon => '/images/icons/actions/create_user_session.png'

  # On sign in
  # Success: Redirect to the path that the server returns
  # Failuer: Show alert
  js_method :on_create_user_session, <<-JS
    function() {
      var form = this.query('form')[0].getForm();
      if (form.isValid()) {
        Ext.MessageBox.buttonText.yes = "OK";
        Ext.MessageBox.buttonText.no = "Cancel";
        Ext.MessageBox.confirm("Information", "<b>FasterNotes</b> is intended for business use only. All data contained herein is confidential and proprietary. Unauthorized access, use, modification, destruction, or disclosure of information supported by this system will result in prosecution. Click <b>OK</b> to continue.", function(btn){
          if(btn == "yes" || btn == "ok"){
            form.submit({success: function(form, action) {
               window.location = action.result.redirect_to;
            },
            failure: function(form, action) {
            if(action.result && (action.result.first_name != null || (action.result.org_staff && action.result.org_staff.first_name != null) ||
              (action.result.field_staff && action.result.field_staff.first_name != null) || (action.result.super_admin && action.result.super_admin.first_name != null) ||
              (action.result.consultant && action.result.consultant.first_name != null))) {
              window.location = "/";
            } else {
              Ext.Msg.alert("Error", "Invalid Email or Password.\\nPlease try again.");
            }
                //Ext.Msg.alert(action.result.errors.message, action.result.errors.reason);
            }});
          }
        });
      }
    }
  JS

  # Submit form on enter and set focus on login
  js_method :init_component, <<-JS
    function() {
      // Call parent
      this.callParent();

      // Get the login textfield
      var textfield = this.query('textfield')[0];

      // set focus on login textfield
      textfield.on('afterrender', function(){this.focus();})
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      var login = Ext.ComponentQuery.query('#login_center')[0];
      var h = Ext.getBody().getViewSize().height;
      if(h >= 630){
        login.setHeight(h);
      }
    }
  JS

end
