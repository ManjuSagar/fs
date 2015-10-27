/*
 * File: app/store/PatientMetaStore.js
 *
 * This file was generated by Sencha Architect version 2.2.2.
 * http://www.sencha.com/products/architect/
 *
 * This file requires use of the Sencha Touch 2.0.x library, under independent license.
 * License of Sencha Architect does not include license for Sencha Touch 2.0.x. For more
 * details see http://www.sencha.com/license or contact license@sencha.com.
 *
 * This file will be auto-generated each and everytime you save your project.
 *
 * Do NOT hand edit this file.
 */

Ext.define('MyApp.store.PatientMetaStore', {
    extend: 'Ext.data.Store',

    requires: [
        'MyApp.model.PatientMetadata'
    ],

    config: {
        data: [
            [
                1,
                'Name',
                'Karthik Krishnan'
            ],
            [
                2,
                'Gender',
                'Male'
            ],
            [
                3,
                'Age',
                '36'
            ],
            [
                4,
                'Location',
                'North Brunswick, NJ 08902'
            ],
            [
                5,
                'Phone',
                '(732) 297 3129'
            ]
        ],
        model: 'MyApp.model.PatientMetadata',
        storeId: 'PatientMetaStore',
        proxy: {
            type: 'memory',
            reader: {
                type: 'array'
            }
        }
    }
});