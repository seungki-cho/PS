import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

//메모리 29,392 kb 실행시간 209 ms

public class Main {
    static long div(long n, int k) {
        if (k == 0) {
            return 1;
        }
        if (k == 1) {
            return n % mod;
        }
        long result;
        if (k % 2 == 0) {
            long x = div(n, k/2);
            result = (x * x) % mod;
        } else {
            long x = div(n, (k - 1) / 2);
            result = ((x * x) % mod * n) % mod;
        }
        return (int)result;
    }

    static int mod = 1_000_000_007;
    static int[] memo;
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int K = Integer.parseInt(st.nextToken());
        long up = 1;
        if (K > N - K) {
            K = Math.min(K, N - K);
        }
        for (int i = N; i >= N-K+1; i--) {
            up = (up * i) % mod;
        }

        long down = 1;
        for (int i = 1; i <= K; i++) {
            down = (down * i) % mod;
        }
        long inverse = div(down, mod - 2) % mod;
        System.out.println((up * inverse) % mod);
    }
}