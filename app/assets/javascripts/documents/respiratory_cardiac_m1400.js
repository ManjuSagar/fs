/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.RespiratoryCardiacM1400', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.respiratoryCardiacM1400',
    border: false,
    items: [
        {
            xtype: 'radiogroup',
            width: 1000,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1400) When is the patient dyspneic or noticeably Short of Breath?',
            cls: 'oasis_pink',
            item_id: 'pat_dyspensic',
            width: "55%",
            labelAlign: 'top',
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '0 - Patient is not short of breath ',
                    inputValue: '00'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '1 - When walking more than 20 feet, climbing stairs',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '2 - With moderate exertion (for example, while dressing, using commode or bedpan, walking distances less than 20 feet) ',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '3 - With minimal exertion (for example, while eating, talking, or performing other ADLs) or with agitation',
                    inputValue: '03'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1400_when_dyspneic',
                    boxLabel: '4 - At rest (during day or night)',
                    inputValue: '04'
                }
            ]
        },
    ],
    onValidate: function(main){
        var errs = new Array();
        m1400Dyspneic = main.down('radiofield[name=m1400_when_dyspneic]').getGroupValue();
        if(m1400Dyspneic == null){
            errs.push(['M1400', "Select the reason when patient feel noticeably short of breath."]);
        }
        return errs;
    }
})
