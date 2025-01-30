import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String[] inputs = scanner.nextLine().split(" ");
        
        int N = Integer.parseInt(inputs[0]);
        int r = Integer.parseInt(inputs[1]);
        int c = Integer.parseInt(inputs[2]);
        
        int n2 = 1;
        for (int i = 0; i < N; i++) {
            n2 *= 4;
        }
        
        int base = 0;
        double dbn2 = n2;
        int rbase = 0;
        int cbase = 0;
        
        for (int i = 0; i < N; i++) {
            boolean right = false;
            boolean down = false;
            rbase = sqrt(n2) / 2 + rbase;
            cbase = sqrt(n2) / 2 + cbase;
            
            if (c >= cbase) {
                right = true;
            }
            if (r >= rbase) {
                down = true;
            }
            
            if (right && down) {
                base += dbn2 * (3.0 / 4);
            } else if (right) {
                base += dbn2 * (1.0 / 4);
                rbase -= sqrt(n2) / 2;
            } else if (down) {
                base += dbn2 * (1.0 / 2);
                cbase -= sqrt(n2) / 2;
            } else {
                cbase -= sqrt(n2) / 2;
                rbase -= sqrt(n2) / 2;
            }
            n2 /= 4;
            dbn2 = n2;
        }
        System.out.println(base);
    }
    
    public static int sqrt(int n) {
        for (int i = 0; i < n; i++) {
            if (i * i == n) {
                return i;
            }
        }
        return -1;
    }
}
