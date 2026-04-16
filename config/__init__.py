import pymysql
pymysql.install_as_MySQLdb()

from django.db.backends.mysql.operations import DatabaseOperations

def last_executed_query(self, cursor, sql, params):
    query = getattr(cursor, '_executed', None)
    if query is not None:
        if isinstance(query, bytes):
            query = query.decode(errors='replace')
        return query
    return sql

DatabaseOperations.last_executed_query = last_executed_query

