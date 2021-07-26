"use strict";
const mySQL_DbConnection = require("./config/db.config");





// Load modules
const path = require("path");
const SHA2 = require("sha2");
const fs = require("fs");
const express = require("express");
const session = require("express-session");
const multer = require("multer");
const storageDest = multer.diskStorage({
  destination: function(req, file, cb) {
      cb(null, './uploads/img/');
   },
  filename: function (req, file, cb) {
      cb(null , (new Date()).getTime().toString() + file.originalname);
  }
});
const fileUpload = multer({storage : storageDest });

const { stringify } = require("querystring");

const app_server = express();
// const http = require("http");
const hostname = "localhost"; // can also use "127.0.0.1", which is the ip for localhost
const port = 3000;

app_server.use(express.urlencoded({ extended: true }));
app_server.use(express.json());
app_server.use( session({ secret : "uNkNoWn", resave : true, saveUninitialized : true }) );

//session object
var sessionOb; 

// get-uploaded_img for products
app_server.get("/uploads/img/:img", (req, res) => {
  try {
    console.log("GET-Upload_img hit.");
    var options = {
      root : path.join(__dirname, "/uploads/img")
    };
    
    var fileName = req.params.img;
    
    if ( !fs.existsSync(options.root + "/" + fileName) ) {
      console.log("404! Requested image not found! Replaced with placeholder!");
      fileName = "imagenotavailable.png";
    }
    res.sendFile(fileName, options, function(err) {
      if (err) {
        console.error(err.message);
        //next(err);
      } else {
        console.log("File sent: ", fileName);
      }
    });

  } catch (err) {
    console.error(err.message);
  }
});

// get-img
app_server.get("/img/:img", (req, res) => {
  try {
    console.log("GET-Img hit.");
    var options = {
      root : path.join(__dirname, "/src/views/img")
    };
    
    var fileName = req.params.img;
    
    if ( !fs.existsSync(options.root + "/" + fileName) ) {
      console.log("404! Requested image not found! Replaced with placeholder!");
      fileName = "imagenotavailable.png";
    }
    res.sendFile(fileName, options, function(err) {
      if (err) {
        console.error(err.message);
        //next(err);
      } else {
        console.log("File sent: ", fileName);
      }
    });

  } catch (err) {
    console.error(err.message);
  }
});

// get-css
app_server.get("/css/:stylesheet", (req, res) => {
  try {
    console.log("GET-Css hit.");
    var options = {
      root : path.join(__dirname, "/src/views/css")
    };
    
    var fileName = req.params.stylesheet;
    
    if ( fs.existsSync(options.root + "/" + fileName) ) {
      res.sendFile(fileName, options, function(err) {
        if (err) {
          console.error(err.message);
          //next(err);
        } else {
          console.log("File sent: ", fileName);
        }
      });
    } else {
      console.log("404! Requested resources not found!");
      res.status(404).json({message : "Requested resources not found!" });
    }

  } catch (err) {
    console.error(err.message);
  }
});

// get-js
app_server.get("/js/:scriptfile", (req, res) => {
  try {
    console.log("GET-Img hit.");
    var options = {
      root : path.join(__dirname, "/src/views/js")
    };
    
    var fileName = req.params.scriptfile;
    
    if ( fs.existsSync(options.root + "/" + fileName) ) {
      res.sendFile(fileName, options, function(err) {
        if (err) {
          console.error(err.message);
          //next(err);
        } else {
          console.log("File sent: ", fileName);
        }
      });
    } else {
      console.log("404! Requested resources not found!");
      res.status(404).json({message : "Requested resources not found!" });
    }

  } catch (err) {
    console.error(err.message);
  }
});



//get-admin-page-dot
app_server.get("/admin/:page.*", (req, res) => {
  try {
    console.log("GET-Admin-Page-dot hit. Redirected to get-admin-page");
    res.redirect("/admin/" + req.params.page);
        
  } catch (err) {
    console.error(err.message);
  }
});
//get-admin-page-slash
app_server.get("/admin/:page/$", (req, res) => {
  try {
    console.log("GET-Admin-Page-slash hit. Redirected to get-admin-page");
    res.redirect("/admin/" + req.params.page);

  } catch (err) {
    console.error(err.message);
  }
});
// get-admin_page
app_server.get("/admin/:page", (req, res) => {
  try {
    console.log("GET-Admin_Page hit.");
    console.log("Admin URL: ", req.params.page);
    console.log("Admin session: ", req.session);

    sessionOb = req.session;

    var options = {
      root : path.join(__dirname, "/src/views/html/admin")
    };
    
    var targetPage = req.params.page.toLowerCase();
    var fileName =  targetPage + ".html";    

    // verify if user is logged-in
    if (sessionOb.user == null || sessionOb.user.username == "") {
        // user is not logged in, redirect to login page
        console.log("user not logged-in -> redirected to login page");
        res.redirect("/login");
    } else if (!sessionOb.user.is_admin) {
        console.log("non-admin user -> redirected to homepage");
        res.redirect("/homepage");
    } else {
        // user is logged-in, send the respective view, i.e. html file
      res.sendFile(fileName, options, function(err) {
        if (err) {
          console.error(err.message);
          if (err.status == 404) {
            res.status(404).send( "404! Sorry! The Requested Page cannot be found!" );
          }
          //next(err);
        } else {
          console.log("File sent: ", fileName);
        }
      });      
    }
    
  } catch (err) {
    console.error(err.message);
  }
});


// get-view_product_by_category
app_server.get("/product/category/:category", (req, res) => {
  try {
    console.log("GET-view_product_by_category hit.");

    sessionOb = req.session;

    //var productCategory = req.params.category;

    var queryStr = "SELECT `product_id`,`product_name`, `product_description`, `product_image_link`, `unit_price` "
      + " FROM `product` "
      + " WHERE `product_category` = ? "
      + " AND `is_removed` = b'0' "
      + " AND `remaining_quantity` > 0 ;";
    
    var queryVar = req.params.category;
    console.log("query var", queryVar);
    mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {             
      if(err) {
        console.log("Error: ", err);
        //console.error(err.message);
        //res.status()
      } else {
        console.log("product id result: ", result_rows);

        var productListing = [];
        for ( var idx = 0; idx < result_rows.length; idx++ )
        {
          var product = { 
            productID : result_rows[idx].product_id,
            productName : result_rows[idx].product_name,
            productDescription : result_rows[idx].product_description,
            productImage : result_rows[idx].product_image_link,
            price : result_rows[idx].unit_price,
          };
          productListing.push(product);
        }
        
        console.log("product listing: ", productListing);
        res.status(200).json({ user : { username : sessionOb.user.username }, productListing: productListing });

      }
    });

  } catch (err) {
    console.error(err.message);
  }
}
);

// get-view_product_by_id
app_server.get("/product/id/:id", (req, res) => {
  try {
    console.log("GET-view_product_by_id hit.");

    sessionOb = req.session;

    //var productID = req.params.id;

    var queryStr = "SELECT `product_id`, `is_removed`,`product_name`, `product_category`, `product_description`, `product_image_link`, `unit_price`, `remaining_quantity` "
      + " FROM `product` "
      + " WHERE `product_id` = ? ;"
    
    var queryVar = req.params.id;
    console.log("query var", queryVar);
    mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {             
      if(err) {
        console.log("Error: ", err);
        //console.error(err.message);
        //res.status()
      } else {
        if (result_rows.length > 0) {
          console.log("product id result: ", result_rows[0]);
        var is_removed = Boolean(result_rows[0].is_removed.toJSON().data[0]);
        var product = { 
          productID : result_rows[0].product_id,
          isRemoved : is_removed,
          productName : result_rows[0].product_name,
          productCategory : result_rows[0].product_category,
          productDescription : result_rows[0].product_description,
          productImage : result_rows[0].product_image_link,
          price : result_rows[0].unit_price,
          remainingQuantity : result_rows[0].remaining_quantity
        };
        console.log("product: ", product);
        res.status(200).json({ user : { username : sessionOb.user.username }, product: product});
        }
      }
    });

  } catch (err) {
    console.error(err.message);
  }
}
);

//get-page-dot
app_server.get("/:page.*", (req, res) => {
  try {
    console.log("GET-Page-dot hit. Redirected to get-page");
    res.redirect("/" + req.params.page);
        
  } catch (err) {
    console.error(err.message);
  }
});
//get-page-slash
app_server.get("/:page/$", (req, res) => {
  try {
    console.log("GET-Page-slash hit. Redirected to get-page");
    res.redirect("/" + req.params.page);

  } catch (err) {
    console.error(err.message);
  }
});

// get-page
app_server.get("/:page", (req, res) => {
  try {
    console.log("GET-Page hit.");
    console.log("URL: ", req.params.page);
    console.log("session: ", req.session);
    sessionOb = req.session;

    var options = {
      root : path.join(__dirname, "/src/views/html")
    };
    
    var targetPage = req.params.page.toLowerCase();
    var fileName =  targetPage + ".html";    
    
    // logging-out
    if (targetPage === "logout") {
      req.session.destroy( function(err) {
        if (err) {
          console.log(err);
        } else {
          res.redirect("/login");
        }
      });
    }
    // verify if user is logged-in
    if (sessionOb.user == null || sessionOb.user.username == "") {
      // verify target page
      // if it is login or register page, no need to be logged-in
      if ( targetPage === "login" || targetPage === "register" ) {
        // send the respective view, i.e. html file
        res.sendFile(fileName, options, function(err) {
          if (err) {
            console.error(err.message);
            if (err.status == 404) {
              res.status(404).send( "404! Sorry! The Requested Page cannot be found!" );
            }
            //next(err);
          } else {
            console.log("File sent: ", fileName);
          }
        });
      } else {
        // user is not logged in and target page is neither login nor register, redirect to login page
        console.log("user not logged-in -> redirected to login page");
        res.redirect("/login");
      }      
    } else {
      // user is already logged-in

      // if it is login or register page, user should be logged out first
      if ( targetPage === "login" || targetPage === "register" ) { 
        req.session.destroy( function(err) {
          if (err) {
            console.log(err);
          } else {
            //res.redirect("/login");
            res.sendFile(fileName, options, function(err) {
              if (err) {
                console.error(err.message);
                if (err.status == 404) {
                  res.status(404).send( "404! Sorry! The Requested Page cannot be found!" );
                }
                //next(err);
              } else {
                console.log("File sent: ", fileName);
              }
            });
          }
        });
      } else {
        // user is logged-in and target page is neither login nor register, send the respective view, i.e. html file
        res.sendFile(fileName, options, function(err) {
          if (err) {
            console.error(err.message);
            if (err.status == 404) {
              res.status(404).send( "404! Sorry! The Requested Page cannot be found!" );
            }
            //next(err);
          } else {
            console.log("File sent: ", fileName);
          }
        });
      }
    }
    
  } catch (err) {
    console.error(err.message);
  }
});

// Basic GET-route, homepage
app_server.get("/", (req, res) => {
  try {
    console.log("Base GET-route hit.");

    sessionOb = req.session;

    var options = {
      root : path.join(__dirname, "/src/views/html")
    };    

    //var fileName = "homepage.html"
    ;    
    if (sessionOb.user == null || sessionOb.user.username == "") {
      res.redirect("/login");
    } else {
      res.redirect("/homepage");
    }
    
    //res.status(200).json({ message: "GET tested!" + JSON.stringify(sessionOb) });

  } catch (err) {
    console.error(err.message);
  }
});



// login post
app_server.post("/login", (req, res) => {
  try {
    console.log("POST-login hit");
    /*
    util.log(util.inspect(req)) // this line helps you inspect the request so you can see whether the data is in the url (GET) or the req body (POST)
    util.log('Request recieved: \nmethod: ' + req.method + '\nurl: ' + req.url) // this line logs just the method and url
    req.on("data", function(chunk) {
      console.log("Data: ", chunk);
      
    });
    console.log("Req Body: ", req.body);
    */
     
    sessionOb = req.session;

    var queryVar = req.body.username;
    var inputPassword = req.body.password;
    
    var queryStr = "SELECT username, user_password, is_admin, is_locked " + 
      "FROM user " + 
      "WHERE username = ? ;";
    
    mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {             
      if(err) {
          console.log("Error: ", err);
          //console.error(err.message);
      } else {
        //console.log("Result row: ", result_rows);
        var hashPassword = SHA2.sha_256(inputPassword);
        //console.log("Hashed Password: ", hashPassword);
        
        if (result_rows.length < 1) {
          console.log("Sorry! This Username, '" + queryVar + "', does not exist!");
          res.status(404).json({ message : "Sorry! This Username, '" + queryVar + "', does not exist!"});
        } else if ( Boolean(result_rows[0].is_locked.toJSON().data[0]) ) {
          console.log("Sorry! This User, '" + queryVar + "', is being locked!");
          res.status(403).json({ message : "Sorry! This User, '" + queryVar + "', is being locked!"});
        } else if (JSON.stringify(result_rows[0].user_password) != JSON.stringify(hashPassword)) {
          console.log("Sorry! Wrong password!");
          res.status(409).json({ message : "Sorry! Wrong password!"});
        } else {
          // finally successfully logged in
          console.log("Welcome, " + queryVar + "!");
          //console.log("is_locked: ", JSON.stringify(result_rows[0].is_locked));
          //res.json({ user : {username : result_rows[0].username, is_admin : result_rows[0].is_admin }, message : "Welcome, " + queryVar + "!"});
          sessionOb.user = { username : "", is_admin : false};
          sessionOb.user.username = result_rows[0].username;
          sessionOb.user.is_admin = ( Boolean(result_rows[0].is_admin.toJSON().data[0]) );
          
          //console.log("req session post-login: ", req.session);
          res.status(200).json({user : { username : sessionOb.user.username, is_admin : sessionOb.user.is_admin } });
          //res.end();
        }          
      }
    });
    //res.end();
  } catch (err) {
    console.error(err.message);
  }
});

// register post
app_server.post("/register", (req, res) => {
  try {
    console.log("POST-register hit");
     
    sessionOb = req.session;

    var inputUsername = req.body.username;
    var inputPassword = req.body.password;
    var hashPassword = SHA2.sha_256(inputPassword);
    var inputEmail = req.body.email;
    var inputPhone =req.body.phone;
    var inputFName = req.body.firstName;
    var inputLName = req.body.lastName;

    var queryVar = [ inputUsername, hashPassword, inputEmail, inputPhone, inputFName, inputLName ];

    // user-table's fields by order:
    // username, hashed user_password, is_admin, is_locked, locked_until_date, email_address, phone_number, first_name, last_name, default_address_id, payment_reception_method
    var queryStr = "INSERT INTO user " + 
      " VALUES ( ?, ?, 0, 0, null, ?, ?, ?, ? ,null, null );";
    
    // send query to insert user
    mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {             
      if(err) {
        console.log("Error: ", err);  
        //console.error(err.message);
        if (err.errno == 1062) {
          console.log("Duplicated User!");
          res.status(409).json({message : "Sorry! This Username, '" +  inputUsername + "', already existed. Please choose another Username and retry! If that was your Username and you forgot your password, please contact the techical support!" });
        }
        
      } else {
        console.log("Welcome, " + inputUsername + "!");
        sessionOb.user = { username : "", is_admin : false};
        sessionOb.user.username = inputUsername;
        console.log("req session post-reg: ", req.session);
        /*
        //res.json({ user : {username : result_rows[0].username, is_admin : result_rows[0].is_admin }, message : "Welcome, " + queryVar + "!"});
        res.status(200).json({user : { username : sessionOb.user.username, is_admin : sessionOb.user.is_admin } });
        */
        res.status(200).json({user : { username : inputUsername, password: hashPassword, is_admin : false } });
          
      }
    });

  } catch (err) {
    console.error(err.message);
  }
});


// POST-sell_item
app_server.post("/sell_item", fileUpload.single("productImage"), (req, res, next) => {
  try {
    console.log("req form body: ", req.body);
    
    sessionOb = req.session;
    // product-table's fields:
    // product_id (auto generated), is_removed, product_name, product_category, product_description, product_image_link, unit_price, initial_quantity, remaining_quantity, seller_username
    // insert fields (8): name, category, description, price, initial quantity, remaining quantity, image_link, seller_username
    var queryStr = "INSERT INTO `product` (`product_name`, `product_category`, `product_description`,`unit_price`, `initial_quantity`, `remaining_quantity`, `product_image_link`, `seller_username`) "
      + " VALUES ( ? , ? , ? , ? , ? , ? , ? , ? );"
    
    
    var productName = req.body.productName;
    var productCategory = req.body.productCategory;
    var productDescription = req.body.productDescription;
    var unitPrice = req.body.price;
    var initialQuantity = req.body.quantity;
    var remainingQuantity = initialQuantity;
    
    var queryVar = [ productName, productCategory, productDescription, unitPrice, initialQuantity, remainingQuantity ];
    if(req.file) {
      console.log("file uploaded: ", req.file.path);
      queryVar.push(req.file.path);
    } else {
      queryVar.push("");
    }

    queryVar.push(sessionOb.user.username);

    // send query to insert product
    mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {             
      if(err) {
        console.log("Error: ", err);  
        //console.error(err.message);
        //res.status()
      } else {
        res.status(200).json({message : "Success! Your item, '" + productName + "', has been added to listing!" });
      }
    });
    
    
  } catch (err) {
    console.error(err.message);
  }
});


// PUT-update_profile
app_server.put("/update_profile", (req, res) => {
  try {
    console.log("PUT-update_profile hit");
    
    sessionOb = req.session;

    var inputFName = req.body.firstName;
    var inputLName = req.body.lastName;
    var inputEmail = req.body.email;
    var inputPhone = req.body.phone;
    
    var queryStr = "UPDATE user SET "; 

    var queryVar = [];
    var prior_term = false;

    if (inputEmail !== "") {
      queryStr += "`email_address`= ? ";
      queryVar.push(inputEmail);
      prior_term = true;
    }


    if (inputPhone !== "") {
      if (prior_term) {
        queryStr += ", ";  
      } else {
        prior_term = true;
      }
      queryStr += "`phone_number`= ? ";
      queryVar.push(inputPhone);
    }

    if (inputFName !== "") {
      if (prior_term) {
        queryStr += ", ";  
      } else {
        prior_term = true;
      }
      queryStr += "`first_name`= ? ";
      queryVar.push(inputFName);
    }

    if (inputLName !== "") {
      if (prior_term) {
        queryStr += ", ";  
      } else {
        prior_term = true;
      }
      queryStr += "`last_name`= ? ";
      queryVar.push(inputLName);
    }

    if (prior_term)
    {
      queryStr += " WHERE (`username` = ? );"
      queryVar.push(sessionOb.user.username);
    }
    
    // send query
    mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {             
      if(err) {
        console.log("Error: ", err);
        res.status(409).json({ message : "Sorry! There were errors updating your profile!" });

      } else {
        console.log("Successfully updated the profile of user '" + sessionOb.user.username + "'!");
        res.status(200).json({ message : "Successfully updated the profile!" });

      }
    });

  } catch (err) {
    console.error(err.message);
  }
});

// PUT-change_password
app_server.put("/change_pass", (req, res) => {
  try {
    console.log("PUT-change_password hit");
    
    sessionOb = req.session;

    var currentPassword = req.body.currentPassword;
    var newPassword = req.body.newPassword;
    var hashCurrentPassword = SHA2.sha_256(currentPassword);
    var hashNewPassword = SHA2.sha_256(newPassword);
    
    var queryStr = "SELECT username, user_password " + 
      "FROM user " + 
      "WHERE username = ? ;";

    var queryVar = [sessionOb.user.username];
    
    // SUGGESTION: better if create a procedure in mysql for updating password so that app server only needs to query once by submitting the required variables
    // first query, verify user enter correct current password
    mySQL_DbConnection.query(queryStr, queryVar, function (err, result_rows, fields) {             
      if(err) {
          console.log("Error: ", err);
          //res.status();
      } else {
        //console.log("db pw: ", result_rows[0].user_password.toJSON().data.toString());
        //console.log("input pw: ", hashCurrentPassword.toJSON().data.toString());
        if ( JSON.stringify(result_rows[0].user_password) !== JSON.stringify(hashCurrentPassword) ) {
          console.log("Sorry! Wrong password!");
          res.status(409).json({ message : "Sorry! Wrong password!"});

        } else {
          console.log("Changing password for user '" + sessionOb.user.username + "'!");
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
              console.log("Successfully changed password for user '" + sessionOb.user.username + "'!");
              res.status(200).json({ message : "Successfully changed password!" });
            }
          });
        }          
      }
    });

  } catch (err) {
    console.error(err.message);
  }
});

// Basic PUT-route
app_server.put("/", (req, res) => {
  try {
    console.log("Base PUT-route hit");
    res.status(200).json({ message: "PUT tested!" });
  } catch (err) {
    console.error(err.message);
  }
});



// Set default route, i.e. 404-page-not-found
app_server.use((req, res) => {
  res.status(404).send( "404! Sorry! The Requested Page cannot be found!" );
});



// Listen for request on port 3000, and as a callback function have the port listened on logged
app_server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});