Ext.define('MyApp.view.SignatureCapture', {
    extend: 'Ext.Container',
    alias : 'widget.signatureCapture',

    layout: {
        type: 'vbox',
        align: 'left'
    },
    height: 250,
    width: 600,
    border: 1,
    items: [
        {
            xtype: 'panel',
            id: 'signature',
            html: '<canvas id="signaturePanel" width="600" height="210">no canvas support</canvas>'
        },
        {
            xtype: 'hidden',
            id: 'signatureContent'
        },
        {
            xtype: 'panel',
            layout: 'hbox',
            items: [
                {
                    xtype: 'button',
                    text: 'Save Signature',
                    hidden: true,
                    id: 'save'
                },
                {
                    xtype: 'button',
                    text: 'Clear Signature',
                    id: 'clear'
                }
            ]
        }
],
    initComponent: function() {
        this.callParent();
        this.down("#signatureContent").name = this.name + "_data";
        this.down("#clear").on("click", function(button) {
            //console.log('Clear Signature button clicked!');
            this.signPad.width = this.signPad.width;
            this.signPadContext.lineWidth = 3;
            //saveButton.disable();
        }, this);
        this.down("#save").on("click", function(button) {
            this.generateSignature();
        }, this);
    },
    generateSignature: function() {
        var data = this.signPad.toDataURL();
        var signatureData = data.replace(/^data:image\/(png|jpg);base64,/, "");
        this.down("#signatureContent").setValue(signatureData);

    },
    afterRender: function() {
        this.callParent();
        console.log('Signature Panel rendered, get ready to Sign!');
        //var view = this.up('container');
        //saveButton = this.down('button[id=save]');

        //get the signature capture panel
        this.signPad = Ext.getDom("signaturePanel");
        if (this.signPad && this.signPad.getContext) {
            this.signPadContext = this.signPad.getContext('2d');
        }

        if (!this.signPad || !this.signPadContext) {
            alert('Error creating signature pad.');
            return;
        }

        this.signPad.width = this.down("#signature").getWidth();
        this.signPad.height = this.down("#signature").getHeight();

        //Mouse events
        _this = this;
        this.signPad.addEventListener('mousedown', function(e){_this.eventSignPad(e)}, false);
        this.signPad.addEventListener('mousemove', function(e){_this.eventSignPad(e)}, false);
        this.signPad.addEventListener('mouseup', function(e){_this.eventSignPad(e)}, false);

        //Touch screen events
        this.signPad.addEventListener('touchstart', function(e){_this.eventTouchPad(e)}, false);
        this.signPad.addEventListener('touchmove', function(e){_this.eventTouchPad(e)}, false);
        this.signPad.addEventListener('touchend', function(e){_this.eventTouchPad(e)}, false);

        sign = new this.signCap();
        this.signPadContext.lineWidth = 3;
    },
    signCap: function()  {
        var sign = this;
        this.draw = false;
        this.start = false;

        this.mousedown = function(event) {
            _this.signPadContext.beginPath();
            _this.signPadContext.arc(event._x, event._y,1,0*Math.PI,2*Math.PI);
            _this.signPadContext.fill();
            _this.signPadContext.stroke();
            _this.signPadContext.moveTo(event._x, event._y);
            sign.draw = true;
//            saveButton.enable();
        };

        this.mousemove = function(event) {
            if (sign.draw) {
                _this.signPadContext.lineTo(event._x, event._y);
                _this.signPadContext.stroke();
            }
        };

        this.mouseup = function(event) {
            if (sign.draw) {
                sign.mousemove(event);
                sign.draw = false;
                _this.generateSignature();
            }
        };

        this.touchstart = function(event) {
            _this.signPadContext.beginPath();
            _this.signPadContext.arc(event._x, event._y,1,0*Math.PI,2*Math.PI);
            _this.signPadContext.fill();
            _this.signPadContext.stroke();
            _this.signPadContext.moveTo(event._x, event._y);
            sign.start = true;
//            saveButton.enable();
        };

        this.touchmove = function(event) {
            event.preventDefault();
            if (sign.start) {
                _this.signPadContext.lineTo(event._x, event._y);
                _this.signPadContext.stroke();
            }
        };

        this.touchend = function(event) {
            if (sign.start) {
                sign.touchmove(event);
                sign.start = false;
            }
        };

    },

    eventSignPad: function(event) {
        if (event.offsetX || event.offsetX == 0) {
            event._x = event.offsetX;
            event._y = event.offsetY;
        } else if (event.layerX || event.layerX == 0) {
            event._x = event.layerX;
            event._y = event.layerY;
        }

        var func = sign[event.type];
        if (func) {
            func(event);
        }

    },

    eventTouchPad: function(event) {

        var mySign = Ext.get("signature");
        //in the case of a mouse there can only be one point of click
        //but when using a touch screen you can touch at multiple places
        //at the same time. Here we are only concerned about the first
        //touch event. Next we get the canvas element's left and Top offsets
        //and deduct them from the current coordinates to get the position
        //relative to the canvas 0,0 (x,y) reference.
        event._x = event.targetTouches[0].pageX - mySign.getX();
        event._y = event.targetTouches[0].pageY - mySign.getY();

        var func = sign[event.type];
        if (func) {
            func(event);
        }

    }

});