function createStateChart (cmp) {
    var statechart = Stativus.createStatechart();
    statechart.cmp = cmp;
    statechart.addState("visited_staff_not_present",
        {
            enterState: function() {                
                this.statechart.cmp.down("#supervised_user_id").hide();
                this.statechart.cmp.down("#visited_user_id").hide();
                var visited_staff_store = this.statechart.cmp.down("#visited_staff").store;
                //visited_staff_store.reload();
            },
            exitState: function() {
                this.statechart.cmp.down("#visit_type_id").show();
            },
            visited_staff_changed: function() {
                this.goToState("visited_staff_present");
            }
        }
    );

    statechart.addState("visited_staff_present",
        {
            enterState: function() {
                this.sendEvent("visited_staff_changed");
            },
            visited_staff_changed: function() {
                if (this.statechart.cmp.down("#visited_staff").getValue() == null)
                    this.goToState("visited_staff_not_present");
                else{
                    var supervisedUserStore = this.statechart.cmp.down("#supervised_user_id").store;
                    supervisedUserStore.remoteFilter = true;
                    supervisedUserStore.clearFilter();
                    supervisedUserStore.filter([{property: "visited_staff_id", value: this.statechart.cmp.down("#visited_staff").value}]);
                    var visitedUserStore = this.statechart.cmp.down("#visited_user_id").store;
                    visitedUserStore.remoteFilter = true;
                    visitedUserStore.clearFilter();
                    visitedUserStore.filter([{property: "visited_staff_id", value: this.statechart.cmp.down("#visited_staff").value}]);
                    this.statechart.cmp.getVisitedStaffIdAndType({visited_staff_id: this.statechart.cmp.down("#visited_staff").getValue()}, function(result) {
                        var visited_staff_type = result["visitedStaffType"];
                        if (visited_staff_type == "IFS") {
                            this.statechart.cmp.down("#visited_user_id").setValue(result["visitedStaffId"]);
                            this.statechart.cmp.resetVisitTypeStore();
                            this.goToState("independent_field_staff_selected");
                        } else if (visited_staff_type == "FS") {
                            this.statechart.cmp.down("#visited_user_id").setValue(result["visitedStaffId"]);
                            this.statechart.cmp.resetVisitTypeStore();
                            this.goToState("dependent_field_staff_selected");
                        } else {
                            this.statechart.cmp.resetVisitTypeStore();
                            this.goToState("staffing_company_selected");
                        }
                    }, this);
                }
            },
            substatesAreConcurrent: true,
            states:
                [
                    ["visit_type_selection",
                        {
                            visited_staff_changed: function() {
                                if (this.statechart.cmp.down("#visited_staff").getValue() == null) {
                                    this.goToState("visited_staff_not_present");
                                } else {
                                    this.goToState("visited_staff_present");
                                }
                            }
                        }
                    ],
                    ["staff_selection",
                        {
                            visited_staff_changed: function() {
                                if (this.statechart.cmp.down("#visited_staff").getValue() != null) {
                                    var supervisedUserStore = this.statechart.cmp.down("#supervised_user_id").store;
                                    supervisedUserStore.remoteFilter = true;
                                    supervisedUserStore.clearFilter();
                                    supervisedUserStore.filter([{property: "visited_staff_id", value: this.statechart.cmp.down("#visited_staff").value}]);
                                    this.statechart.cmp.down("#visited_user_id").setValue(null);
                                    var visitedUserStore = this.statechart.cmp.down("#visited_user_id").store;
                                    visitedUserStore.remoteFilter = true;
                                    visitedUserStore.clearFilter();
                                    visitedUserStore.filter([{property: "visited_staff_id", value: this.statechart.cmp.down("#visited_staff").value}]);
                                    this.statechart.cmp.getVisitedStaffIdAndType({visited_staff_id: this.statechart.cmp.down("#visited_staff").getValue()}, function(result) {
                                        var visited_staff_type = result["visitedStaffType"];
                                        if (visited_staff_type == "IFS") {
                                            this.statechart.cmp.down("#visited_user_id").setValue(result["visitedStaffId"]);
                                            this.statechart.cmp.resetVisitTypeStore();
                                            this.goToState("independent_field_staff_selected");
                                        } else if (visited_staff_type == "FS") {
                                            this.statechart.cmp.down("#visited_user_id").setValue(result["visitedStaffId"]);
                                            this.statechart.cmp.resetVisitTypeStore();
                                            this.goToState("dependent_field_staff_selected");
                                        } else {
                                            this.statechart.cmp.resetVisitTypeStore();
                                            this.goToState("staffing_company_selected");
                                        }
                                    }, this);
                                }
                            },
                            states:[
                                ["independent_field_staff_selected",
                                    {
                                        enterState: function() {
                                            this.statechart.cmp.down("#supervised_user_id").hide();
                                        }
                                    }
                                ],
                                ["dependent_field_staff_selected",
                                    {
                                        enterState: function() {
                                            this.statechart.cmp.down("#supervised_user_id").show();
                                            this.statechart.cmp.down("#visited_user_id").hide();
                                        }
                                    }
                                ],
                                ["staffing_company_selected",
                                    {
                                        enterState: function() {
                                            this.statechart.cmp.down("#visited_user_id").show();
                                            this.statechart.cmp.resetVisitTypeStore();
                                        },
                                        exitState: function() {
                                            this.statechart.cmp.down("#visited_user_id").hide();
                                        },
                                        initialSubstate: "sc_field_staff_not_present",
                                        states:[
                                            ["sc_field_staff_not_present",
                                                {
                                                    enterState: function() {
                                                        this.statechart.cmp.down("#supervised_user_id").hide();
                                                    }
                                                }
                                            ],
                                            ["sc_field_staff_present",
                                                {
                                                    states:[
                                                        ["independent_sc_staff_selected",
                                                            {
                                                                enterState: function() {
                                                                    this.statechart.cmp.down("#supervised_user_id").hide();
                                                                },
                                                                visited_staff_changed: function() {
                                                                    if (this.statechart.cmp.down("#visited_staff").getValue() == null) {
                                                                        this.goToState("visited_staff_not_present");
                                                                    } else {
                                                                        this.goToState("visited_staff_present");
                                                                    }
                                                                }
                                                            }
                                                        ],
                                                        ["dependent_sc_staff_selected",
                                                            {
                                                                enterState: function() {
                                                                    this.statechart.cmp.down("#supervised_user_id").show();
                                                                },
                                                                visited_staff_changed: function() {
                                                                    if (this.statechart.cmp.down("#visited_staff").getValue() == null) {
                                                                        this.goToState("visited_staff_not_present");
                                                                    } else {
                                                                        this.goToState("visited_staff_present");
                                                                    }
                                                                }
                                                            }
                                                        ]
                                                    ]
                                                }
                                            ]
                                        ]
                                    }
                                ]
                            ]
                        }
                    ]
                ]
        });
    statechart.initStates("visited_staff_not_present");
    return statechart;
}
