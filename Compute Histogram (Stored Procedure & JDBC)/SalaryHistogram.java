import java.sql.*;

class SalaryHistogram {

    public static void main(String[] args) {
        try {
            Class.forName("com.ibm.db2.jcc.DB2Driver");
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            double start_value = 0;
            double end_value = 0;
            int bin_nums = 0;
            if (args.length == 6) {
                String url = args[0];
                String userid = args[1];
                String passwd = args[2];
                start_value = Double.parseDouble(args[3]);
                end_value = Double.parseDouble(args[4]);
                bin_nums = Integer.parseInt(args[5]);
                con = DriverManager.getConnection(url, userid, passwd);
                System.out.println("Successfully connected to " + args[0]);
            } else {
                throw new Exception(
                        "\n Usage: java SalaryHistogram <dburl> <username> <password> <start_value> <end_value> <bin_numbers>\n");
            }
            double bin_width = (end_value - start_value) / bin_nums;
            int[] bins = new int[bin_nums];

            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT TRUNC((SALARY - " + start_value + ") / " + bin_width
                    + ") AS BINNUM From EMPLOYEE WHERE SALARY >= " + start_value + " AND SALARY < " + end_value);

            while (rs.next()) {
                int bin_num = rs.getInt("BINNUM");
                bins[bin_num] += 1;
            }
            for (int i = 0; i < bin_nums; i++) {
                int bin_num = i + 1;
                int frequencies = bins[i];
                double bin_start = (i * bin_width) + start_value;
                double bin_end = bin_start + bin_width;

                System.out.println("BINNUM: " + bin_num + ", FREQUENCY: " + frequencies + ", BINSTART: " + bin_start
                        + ", BINEND: " + bin_end);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}