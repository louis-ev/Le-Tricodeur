//
// http://linuxsleuthing.blogspot.fr/2012/10/whos-texting-ios6-smsdb.html
//

class SMS
{
  String driver = "org.sqlite.JDBC";
  String url = "";
  Connection connection;
  boolean isConnected = false;

  final static int RECEIVED = 0;
  final static int SENT = 1;

  boolean DEBUG = false;

  String strDateMacToUnix = "DATETIME(date + 978307200, 'unixepoch', 'localtime')";

  void setDebug(boolean is_){DEBUG=is_;}

  boolean connect(String filename_)
  {
    this.url = "jdbc:sqlite:" + dataPath(filename_);

    try
    {
      Class.forName(driver);
      connection = DriverManager.getConnection(url, "", "");
    }
    catch (ClassNotFoundException e)
    {
      System.out.println( "SQL.connect(): Could not find the database driver ( "+driver+" ).\r" );
      connection = null;
    }
    catch (SQLException e)
    {
      System.out.println( "SQL.connect(): Could not connect to the database ( "+url+" ).\r" );
      connection = null;
    }

    this.isConnected =  connection == null ? false : true;

    return this.isConnected;
  }

  int getCountPerHour(int year, int hour, int receivedOrSent)
  {
    if (isConnected == false)
    {
      println("SMS::getCountSMSPerHour - not connected to database");
      return 0;
    }

    if (hour<0 || hour>23)
    {
      println("SMS::getCountSMSPerHour - "+hour+" is an invalid hour");
      return 0;
    }
    else
    {
      try
      {
        Statement query = connection.createStatement();
        String strQuery = "SELECT COUNT(m.rowid) AS nbSMS FROM message m WHERE";
        strQuery += " strftime('%H', "+strDateMacToUnix+")='"+( hour < 10 ? "0"+hour : hour)+"'";
        strQuery += " AND strftime('%Y', "+strDateMacToUnix+")='"+year+"'";
        strQuery += " AND is_from_me='"+receivedOrSent+"'";

        if (DEBUG)
          println(strQuery);

        ResultSet rs = query.executeQuery(strQuery);
        int nb=0;
        if (rs.next())
        {
          nb = rs.getInt("nbSMS");
        }

        rs.close();
        query.close();

        return nb;
      }
      catch(SQLException e)
      {
        println(e);
      }
    }

    return 0;
  }
}



