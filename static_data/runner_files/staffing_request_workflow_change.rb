StaffingRequest.update_all("request_status = 'D'", "request_status = 'X'")
StaffingRequest.update_all("request_status = 'E'", "request_status = 'P'")
StaffingRequest.update_all("request_status = 'S'", "request_status = 'A'")
StaffingRequest.update_all("request_status = 'C'", "request_status = 'R'")