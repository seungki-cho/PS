import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class Main {

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        StringBuilder sb = new StringBuilder();
        long[] dp = new long[5001];
        dp[0] = 1;
        
        dp[2] = 1;

        for(int i = 4; i < 5001; i+=2) {
            for(int j = 2; j <= i; j+=2) {
                dp[i] += (dp[j-2] * dp[i-j]) % 1_000_000_007l;
                dp[i] = dp[i] % 1_000_000_007l;
            }
        }
        for(int i = 0; i < N; i++) {
            // sb.append(dp[Integer.parseInt(br.readLine())] + "\n");
            System.out.println(dp[Integer.parseInt(br.readLine())]);
        }
        
        br.close();
    }
}