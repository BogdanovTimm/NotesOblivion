import psycopg
from config import load_config









def connect(config):
    with psycopg.connect(**config) as conn: # Connect to an existing database
        with conn.cursor() as cur:          # Open a cursor to perform database operations
            cur.execute("SELECT * FROM test") # Query the database and obtain data as Python objects.
            cur.fetchone() # Return (1, 100, "abc'def"). cur.fetchmany(), cur.fetchall()
            for record in cur:
                print(record)
            # conn.commit() # Make the changes to the database persistent









if __name__ == '__main__':
    config = load_config()
    connect(config)
