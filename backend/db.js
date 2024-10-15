import mysql from 'mysql2';

export const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  database: 'lanchonete',
  authPlugins: {
    sha256_password: () => mysql.authPlugins.sha256_password,
    mysql_native_password: () => mysql.authPlugins.mysql_native_password,
  }
});

db.connect(err => {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }
  console.log('connected as id ' + db.threadId);
});
