I have performed a series of data cleaning and analysis steps on the Nobel_Awardees data using Microsoft SQL Management Studio. Here's a structured summary of my tasks:

### Data Cleaning Steps: 

1. **Date Format Change:**
   - The date formats of "Born" and "Died" columns were converted from YYYY-MM-DD to YYYY.

2. **Life Expectancy Column Creation:**
   - Life expectancy was calculated based on the "Born" and "Died" years, and the results were added as a new column.

3. **First and Last Names Combination:**
   - The "First Name" and "Last Name" columns were concatenated to create a new "Name" column.

4. **Country and City Name Updates:**
   - Old country and city names were replaced with recent names to maintain accuracy.

5. **Gender Format Standardization:**
   - Gender values were transformed to "M" for male and "F" for female.

6. **Unused Column Deletion:**
   - Unnecessary columns that were no longer needed after cleaning and analysis were removed.

### Data Analysis Steps:

1. **Nobel Winners Count by Category:**
   - The data was grouped by "Category" and the number of Nobel Prize winners in each category was counted.

2. **Nobel Prize Count Listing by Year:**
   - The year with the highest number of Nobel Prize awards was identified.
   - The count of Nobel Prizes awarded in each category for that year was listed.

3. **Selection of Male Physics Awardees from USA before WW2:**
   - Data for male Nobel Prize awardees in the "Physics" category from the USA was retrieved.
   - The results were filtered to include only awardees who received their awards before World War 2.
  
   
### Data Export Steps:

1. **Cleaned Data Export Using bcp:**
   - The Command Prompt was opened.
   - The `bcp` utility was used to export the cleaned data from the specified database, schema, and table to a designated file.
     
   - The syntax is as follows:
   - Syntax: 
     ```
     bcp <database_name>.<schema_name>.<table_name> out <file_destination_path> -S<server_instance> -c -t"," -T
     ```
     - `<database_name>`: Name of the database containing the cleaned data.
     - `<schema_name>`: Name of the schema containing the cleaned data.
     - `<table_name>`: Name of the table containing the cleaned data.
     - `<file_destination_path>`: Path to the destination file where the cleaned data will be saved.
     - `-S<server_instance>`: The server instance where the database is hosted.
     - `-c`: Specifies character data format.
     - `-t","`: Specifies the field terminator as a comma.
     - `-T`: Uses Windows authentication for the connection.


Upon completion of these steps, the cleaned and analyzed data will be saved in the specified file destination.

### Data Visualization Steps:
