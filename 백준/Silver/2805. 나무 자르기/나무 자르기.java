import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        long M = Long.parseLong(st.nextToken());
        long[] li = new long[N];

        st = new StringTokenizer(br.readLine());
        for(int i = 0; i < N; i++){
            li[i] = Long.parseLong(st.nextToken());
        }
        long l = 0;
        long r = 2_000_000_000;
        long ans = 0;

        while (l <= r) {
            long m = (l + r) / 2;
            long sum = 0;

            for(int i = 0; i < N; i++) {
                sum += (li[i] <= m) ? 0 : (li[i] - m);
            }

            if (M <= sum) {
                l = m+1;
                ans = m;
            } else {
                r = m-1;
            }
        }
        System.out.println(ans);
    }
}