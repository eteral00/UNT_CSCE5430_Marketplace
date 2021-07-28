// PUT-admin_delete_user
app_server.put("/admin/delete_product", (req, res) => {
    try {
      console.log("PUT-change_password hit");
      
      sessionOb = req.session;
  
      var userName = req.body.userName;
      var productId = req.body.productId
      
      var queryStr = "SELECT username, user_password " + 
        "FROM user " + 
        "WHERE username = ? ;";
  
      var queryVar = [productId];
      
      // SUGGESTION: better if create a procedure in mysql for updating password so that app server only needs to query once by submitting the required variables
      // first query, verify user enter correct current password
      mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {             
        if(err) {
            console.log("Error: ", err);
            //res.status();
        } else {
          
            console.log("Changing is locked for user '" + userName + "' as !" );
  
            queryStr = "DELETE FROM user WHERE (`product_id` = ? ); " ;
            // send 2nd query to change password
            mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {
              if(err) {
                console.log("Error: ", err);
                //res.status();
              } else {
                console.log("Successfully changed password for user '" + userName + "'!");
                res.status(200).json({ message : "Successfully deleted product!" });
              }
            });
          }          
        
      });
  
    } catch (err) {
      console.error(err.message);
    }
  });
  
  // PUT-admin_modify_user
  app_server.put("/admin/modify_product", (req, res) => {
    try {
      console.log("PUT-change_password hit");
      
      sessionOb = req.session;
  
      var userName = req.body.userName;
      var productId = req.body.productId;
      
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
          
            console.log("Changing is locked for user '" + userName + "' as !" +productId);
            queryVar.unshift((productId) ? 1 : 0);
  
            queryStr = "UPDATE product " + 
              " SET `is_removed`= "+1+
              " WHERE (`product_id` = ? );";
  
            // send 2nd query to change password
            mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {
              if(err) {
                console.log("Error: ", err);
                //res.status();
              } else {
                console.log("Successfully changed password for user '" + userName + "'!");
                res.status(200).json({ message : "Successfully blocked product!" });
              }
            });
          }          
        
      });
  
    } catch (err) {
      console.error(err.message);
    }
  });