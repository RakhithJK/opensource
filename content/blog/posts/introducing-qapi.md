+++
date = "2019-11-07T10:00:00-08:00"
draft = false
title = "Introducing qAPI: Translating database queries into API calls"
categories = ["resources"]
tags = ["testing", "API", "database"]
author = "Julio Zevallos"

+++

Designing and implementing test flows typically involves validating data with one or multiple databases. 
Whether it may be a simple test script, test frameworks such as Selenium (R), or test applications such as Tosca (R), querying the database directly is often not a good approach (from security and maintainability standpoints), and sometimes, not even fully supported.

In order to remove the database connections from such tests, T-Mobile’s Test Platform Engineering team developed qAPI (which stands for query API). qAPI eases the process by converting a database query to an API service that testers can integrate with in order to retrieve data in their test scripts. With this design, they can simply make an API call whenever needed, keeping their tests clean and modular. Additionally, if certain test frameworks don’t provide the drivers needed to connect to certain databases, qAPI removes this constraint and allows for more flexibility and expandability on database-type support.

[Video](https://www.youtube.com/watch?v=IRU-AcRGL74&feature=youtu.be)

# The benefits of using qAPI include:

- Reduced effort: qAPI only needs database query and credentials to create an API by letting dynamic values be passed to queries through the body of a POST API call and automatically creating JSON response from database query output. Testers don’t need to write a line of code to enable an API.

- Increased security: Maintaining all database connection and credentials information centrally outside test scripts with optional integration to T-Vault, which is a secret management tool opensourced by T-Mobile.

- Reusability and sharing: Maintaining all the queries on a user specified repository, where teams can save and update their queries on a key-value basis.

- Sanitizing user input: qAPI transforms the query from the config files into a prepared statement, passing in the dynamic parameters to it, which sanitizes any value the user passes in through the body of the request and prevents any API calls from going rogue.

- Growing database support: qAPI currently supports Oracle (R), SQL Server, and Cassandra (R) databases. Other databases integration can be enabled in the future by community. 

<table>
 <tr>
    <td style="padding: 30px">
        <h2>Design without qAPI</h2>
        <image src="https://raw.githubusercontent.com/tmobile/qapi/master/misc/without%20qAPI.png" />
    </td>
    <td style="padding: 30px">
        <h2>Design without qAPI</h2>    
        <image src="https://raw.githubusercontent.com/tmobile/qapi/master/misc/without%20qAPI.png" />
    </td>
    </td>
 </tr>
</table>
 
With these capabilities, teams no longer will have to overload their test dependencies with JDBC drivers, as well as other dependencies needed to manage connections. Also, all database configurations are centralized in one location so if credentials ever need to be added or updated, they can be done in one location, rather than on a test by test basis. To learn more or contribute to qAPI on GitHub – code (https://github.com/tmobile/qapi) and wiki (https://github.com/tmobile/qapi/wiki)  

# License

qAPI is open-sourced under the terms of the Apache 2.0 license and is released AS-IS WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND pursuant to Section 7 of the Apache 2.0 license.
