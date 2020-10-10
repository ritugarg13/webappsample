var crypto = require("crypto");  

const verb = "GET";
const resourceType = "docs";
const resourceId = "dbs/testdb/colls/customer";
const expiry = "Thu, 06 Aug 2020 06:25:40 GMT";
const key = "lOA33Y6ECKSX0oOXI4bj7GB338yK1QGd0CLvZARfjYFSPzGripvu7JVzSFCXRf1BcEtLr87o4mnxE7HQXvuPtA==";

console.log(getAuthorizationTokenUsingMasterKey(verb, resourceType, resourceId, expiry, key));

function getAuthorizationTokenUsingMasterKey(verb, resourceType, resourceId, date, masterKey) {  
    var key = new Buffer(masterKey, "base64");  
  
    var text = (verb || "").toLowerCase() + "\n" +   
               (resourceType || "").toLowerCase() + "\n" +   
               (resourceId || "") + "\n" +   
               date.toLowerCase() + "\n" +   
               "" + "\n";  
  
    var body = new Buffer(text, "utf8");  
    var signature = crypto.createHmac("sha256", key).update(body).digest("base64");  
  
    var MasterToken = "master";  
  
    var TokenVersion = "1.0";  
  
    return encodeURIComponent("type=" + MasterToken + "&ver=" + TokenVersion + "&sig=" + signature);  
}
