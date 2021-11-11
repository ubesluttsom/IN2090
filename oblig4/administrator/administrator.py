import psycopg2

# MERK: Må kjøres med Python 3!

# Login details for database user.
dbname = "martimn" #Set in your UiO-username
user = "martimn_priv" # Set in your priv-user (UiO-username + _priv)
pwd = "puPh3ouWah" # Set inn the password for the _priv-user you got in a mail

# Gather all connection info into one string.
connection = \
    "host='dbpg-ifi-kurs01.uio.no' " + \
    "dbname='" + dbname + "' " + \
    "user='" + user + "' " + \
    "port='5432' " + \
    "password='" + pwd + "'"


def administrator():
    conn = psycopg2.connect(connection)
    
    ch = 0
    while (ch != 3):
        print("-- ADMINISTRATOR --")
        print("Please choose an option:\n "
              "1. Create bills\n "
              "2. Insert new product\n "
              "3. Exit")
        ch = get_int_from_user("Option: ", True)

        if (ch == 1):
            make_bills(conn)
        elif (ch == 2):
            insert_product(conn)

    
def make_bills(conn):
    cur = conn.cursor()

    # Query the database for orders, join the relevant tables to create a tuple
    # with the precise values we need. I have chosen to list the totals for
    # each *order* in SQL, and do the summation per *user* in Python code
    # below.

    cur.execute(
        """
        SELECT uid,
               ws.users.name,
               ws.users.address,
               ws.orders.num * ws.products.price
         FROM ws.orders
              JOIN ws.products USING (pid)
              JOIN ws.users USING (uid)
        WHERE payed = 0;
        """
    )

    # I make use of dictionaries so store the values, it makes retrieval dead
    # simple when printing, below.

    recipients = {}
    addresses  = {}
    total_dues = {}

    for (uid, name, address, total) in cur.fetchall():
        if uid in total_dues:
            total_dues[uid] = total_dues[uid] + total
        else:
            recipients[uid] = name
            addresses[uid]  = address
            total_dues[uid] = total

    for (uid, total) in total_dues.items():
        if total == 0:
            continue
        print(f"---Bill---")
        print(f"Name: {recipients[uid]}")
        print(f"Address: {addresses[uid]}")
        print(f"Total due: {total}")
        print(f"")


def insert_product(conn):
    cur = conn.cursor()

    # Create a dictionary of valid category names to `cid`s beforehand. This
    # makes simplifies the validity check below.

    cids = {}
    cur.execute(
        """
        SELECT cid, name
          FROM ws.categories;
        """
    )
    for (cid, name) in cur.fetchall():
        cids[name] = cid

    print("-- Insert new product --")

    # Get name, category, price and description. Do an existence check for
    # `category`; only accept valid names. Also, make sure the `price` is an
    # actual float.

    name = input("Product name: ")

    while True:
        category = input("Category: ")
        if category in cids:
            category = cids[category]
            break
        else:
            print(f"Must be one of: {list(cids.keys())}")

    while True:
        try:
            price = float(input("Price: "))
            break
        except ValueError:
            print("Must be float!")

    description = input("Description: ")

    # Finally, insert and commit the values to database.

    cur.execute(
        """
        INSERT INTO ws.products (name, price, cid, description)
        VALUES (%s, %s, %s, %s);
        """,
        (name, price, category, description),
    )
    conn.commit()

    print(f"New product {name} inserted.")


def get_int_from_user(msg, needed):
    # Utility method that gets an int from the user with the first argument as
    # message Second argument is boolean, and if false allows user to not give
    # input, and will then return None.

    while True:
        numStr = input(msg)
        if (numStr == "" and not needed):
            return None;
        try:
            return int(numStr)
        except:
            print("Please provide an integer or leave blank.");


if __name__ == "__main__":
    administrator()
