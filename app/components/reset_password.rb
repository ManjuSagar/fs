class ResetPassword < Netzke::Base
  # Set the EXT JS class
  js_base_class 'Ext.Window'
  include Spawn

  # Configure the component
  #
  # @return [Hash]
  def configuration
    super.merge(
        :title => "Reset Password",
        :layout => 'fit',
        :hidden => false,
        :width => 350,
        :padding => 10,
        :y => 100,
        :auto_height => true,
        :closable => false,
        :resizable => false,
        :items => [{
           :xtype => :form,
           :frame => true,
           :border => false,
           :padding => 5,

           :url => Netzke::Core.controller.reset_password_path(:format => :json),
           :default_type => :textfield,
           :defaults => {
               :anchor => '100%',
               :allowBlank => false,
               :enable_key_events => true,
               :listeners => {
                   :special_key => <<-JS.l
                   function(field, e)
                   {
                     // if user presses ENTER => call onSignIn()
                     if(e.getKey() == Ext.EventObject.ENTER)
                     {
                       field.up('window').onResetPassword();
                     }
                   }
                   JS
               }
           },
           :items => [{
                          :name => 'user[email]',
                          :field_label => User.human_attribute_name(:email),
                          :vtype => :email
                      }]
        }],
        :buttons => [:reset_password.action],

    )
  end

  action :reset_password, :text => "Reset Password", :tooltip => "Reset the password"

  js_method :on_reset_password, <<-JS
    function() {
      //var form = this.down('form');
      var userEmail = this.down('textfield').value;
      var  form = this.query('form')[0].getForm();
      if(form.isValid()){
      this.resetPassword({email: userEmail}, function(result){
            if(result){
               Ext.Msg.alert("Success", "Your Password has been reset successfully.</br> Please check your email for further instructions.", function(btn, text){
                  if(btn=='ok'){
                    window.location.href = "/signin"
                  }

               });

            }else{
              Ext.Msg.alert("Success", "Your Password has been reset successfully.</br> Please check your email for further instructions.", function(btn, txt){
                  if(btn=='ok'){
                    window.location.href = "/signin"
                  }
              });

            }
      });
      }else{
          Ext.Msg.alert("Failure", "Please enter a valid email.");
       }
    }
  JS

  endpoint :reset_password do |params|
    user = User.find_by_email(params[:email])
    if user
      user.reset_user_password
      spawn_block do
        FasternotesMailer.user_password_reset_information(user).deliver
      end
    end
    {:set_result => user}
  end


end