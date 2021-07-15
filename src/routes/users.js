const express = require("express");
const bcrypt = require("bcrypt");

function getUsersRouter() {
  const router = express.Router();

  // login route
    router.post("/login", async (req, res) => {
        console.log("POST /login hit.");
        try {
            // Grab username & password from request body
            console.log(req.body);
            const username = req.body.username;
            const password = req.body.password;

            // Ensure both username & password were entered
            if (!username || !password) {
                throw new Error("username or password is missing");
            }  

            // query to get user from database using user name
            //const user = await ;
            var query_str = 
                "SELECT user_name, user_password, is_admin " +
                "FROM user " +   
                "WHERE (user_name = ?) " +
                "LIMIT 1 ";

            var query_var = [username];

            var user = {};
            
            var query = connection.query(query_str, query_var, function (err, rows, fields) {
                if (err) {
                    console.log(err);
                } else {
                //console.log(rows);
                    if (rows.length > 0) {
                        user = rows[0];
                    }
                }
            });

            // match password to authenticate
            //var match;
            // compare with encrypted if password was not encrypted from front-end
            /*
            match = await bcrypt.compare(password, user.user_password).catch(err => {
                throw Error("Problem comparing the passwords");
            });
            */

            // compare if password already encrypted from front-end
            if (user) {
                if (user.is_locked)
                {
                    res.status(200).json({
                        success: false,
                        message: "User is locked!"
                    });
                } else {
                    if (password == user.user_password)
                    {
                        res.status(200).json({
                            success: true,
                            username: user.user_name,
                            is_admin: user.is_admin
                        });
                    } else {
                        res.status(200).json({
                            success: false,
                            message: "Wrong Password!"
                        });    
                    }
                }
                
            } else {
                res.status(200).json({
                    success: false,
                    message: "This user does not exist!"
                });
            }
        } catch (err) {
            res.status(400).json({ error: err.message });
        }
    });


  return router;
}

module.exports = { getUsersRouter };