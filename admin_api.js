// PUT-change_password_admin
app_server.put("/admin/change_pass_admin", (req, res) => {
    try {
      console.log("PUT-change_password hit");
      
      sessionOb = req.session;
  
      var userName = req.body.userName;
      var newPassword = req.body.newPassword;
      var hashNewPassword = SHA2.sha_256(newPassword);
      
      var queryStr = "SELECT username, user_password " + 
        "FROM user " + 
        "WHERE username = ? ;";
  
      var queryVar = [userName];
      
      // SUGGESTION: better if create a procedure in mysql for updating password so that app server only needs to query once by submitting the required variables
      // first query, verify user enter correct current password
      mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {             
        if(err) {
            console.log("Error: ", err);
            //res.status();
        } else {
          
            console.log("Changing password for user '" + userName + "'!");
            queryVar.unshift(hashNewPassword);
  
            queryStr = "UPDATE user " + 
              " SET `user_password`= ? " +
              " WHERE (`username` = ? );";
  
            // send 2nd query to change password
            mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {
              if(err) {
                console.log("Error: ", err);
                //res.status();
              } else {
                console.log("Successfully changed password for user '" + userName + "'!");
                res.status(200).json({ message : "Successfully changed password!" });
              }
            });
          }          
        
      });
  
    } catch (err) {
      console.error(err.message);
    }
  });
  

// PUT-change_password_admin
app_server.put("/admin/change_pass_admin", (req, res) => {
    try {
      console.log("PUT-change_password hit");
      
      sessionOb = req.session;
  
      var userName = req.body.userName;
      var newPassword = req.body.newPassword;
      var hashNewPassword = SHA2.sha_256(newPassword);
      
      var queryStr = "SELECT username, user_password " + 
        "FROM user " + 
        "WHERE username = ? ;";
  
      var queryVar = [userName];
      
      // SUGGESTION: better if create a procedure in mysql for updating password so that app server only needs to query once by submitting the required variables
      // first query, verify user enter correct current password
      mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {             
        if(err) {
            console.log("Error: ", err);
            //res.status();
        } else {
          
            console.log("Changing password for user '" + userName + "'!");
            queryVar.unshift(hashNewPassword);
  
            queryStr = "UPDATE user " + 
              " SET `user_password`= ? " +
              " WHERE (`username` = ? );";
  
            // send 2nd query to change password
            mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {
              if(err) {
                console.log("Error: ", err);
                //res.status();
              } else {
                console.log("Successfully changed password for user '" + userName + "'!");
                res.status(200).json({ message : "Successfully changed password!" });
              }
            });
          }          
        
      });
  
    } catch (err) {
      console.error(err.message);
    }
  });
  