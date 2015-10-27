/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.SensoryStatusM1200M1230', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.sensoryStatusM1200M1230',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1200) Vision (with corrective lenses if the patient usually wears them)",
            width: "91%",
            cls: 'oasis_green',
            itemId: 'pat_vision',
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1200_vision",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Normal vision: sees adequately in most situations; can see medication labels, newsprint.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1200_vision",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Partially impaired: cannot see medication labels or newsprint, but can see obstacles in path, and the surrounding layout; can count fingers at arm`s length.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1200_vision",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Severely impaired: cannot locate objects without hearing or touching them or patient nonresponsive.'
                }
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1210) Ability to hear (with hearing aid or hearing appliance if normally used)",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1210_hearg_ablty",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Adequate: hears normal conversation without difficulty.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1210_hearg_ablty",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Mildly to Moderately Impaired: difficulty hearing in some environments or speaker may need to increase volume or speak distinctly.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1210_hearg_ablty",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Severely Impaired: absence of useful hearing.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1210_hearg_ablty",
                    inputValue: "UK",
                    margin: 5,
                    boxLabel: 'UK - Unable to assess hearing.'
                }
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1220) Understanding of Verbal Content in patient's own language (with hearing aid or device if used)",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1220_undrstg_verbal_cntnt",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Understands: clear comprehension without cues or repetitions.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1220_undrstg_verbal_cntnt",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Usually Understands: understands most conversations, but misses some part/intent of message. Requires cues at times to understand.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1220_undrstg_verbal_cntnt",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Sometimes Understands: understands only basic conversations or simple, direct phrases. Frequently requires cues to understand.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1220_undrstg_verbal_cntnt",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Rarely/Never Understands'
                },
                {
                    xtype: 'radiofield',
                    name: "m1220_undrstg_verbal_cntnt",
                    inputValue: "UK",
                    margin: 5,
                    boxLabel: 'UK - Unable to assess understanding.'
                }
            ]
        },{
            xtype: 'radiogroup',
            fieldLabel: "(M1230) Speech and Oral (Verbal) Expression of Language (in patient`s own language)",
            labelAlign: 'top',
            cls: 'oasis_blue',
            width: "92%",
            itemId: 'pat_speech_and_oral',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Expresses complex ideas, feelings, and needs clearly, completely, and easily in all situations with no observable impairment.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Minimal difficulty in expressing ideas and needs (may take extra time; makes occasional errors in word choice, grammar or speech intelligibility; needs minimal prompting or assistance).'
                },
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Expresses simple ideas or needs with moderate difficulty (needs prompting or assistance,errors in word choice, organization or speech intelligibility). Speaks in phrases or short sentences.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Has severe difficulty expressing basic ideas or needs and requires maximal assistance or guessing by listener. Speech limited to single words or short phrases.'
                },
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - Unable to express basic needs even with maximal prompting or assistance but is not comatose or unresponsive (for example, speech is nonsensical or unintelligible).'
                },
                {
                    xtype: 'radiofield',
                    name: "m1230_speech",
                    inputValue: "05",
                    margin: 5,
                    boxLabel: '5 - Patient nonresponsive or unable to speak.'
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        m1200Vision = main.down('radiofield[name=m1200_vision]').getGroupValue();
        m1210Hearg = main.down('radiofield[name=m1210_hearg_ablty]').getGroupValue();
        m1220Verbal = main.down('radiofield[name=m1220_undrstg_verbal_cntnt]').getGroupValue();
        m1230Speech = main.down('radiofield[name=m1230_speech]').getGroupValue();
        if(m1200Vision == null){
            errs.push(['M1200', "Select one item from Vision"]);
        }
        if(m1210Hearg == null){
            errs.push(['M1210', "Select one option from Patient's ability to hear."]);
        }
        if(m1220Verbal == null){
            errs.push(['M1220', "Select one mode of understanding the patient's Verbal Content."]);
        }
        if(m1230Speech == null){
            errs.push(['M1230', "Select at least one way how the patient is able to convey the Speech and Oral Communication."]);
        }
        return errs;
    }

})
