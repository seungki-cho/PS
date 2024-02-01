import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int ans = 21412419;
        int[] sins = new int[N];
        int[] sseuns = new int[N];

        for(int i = 0; i < N ;i++){
            st = new StringTokenizer(br.readLine());
            sins[i] = Integer.parseInt(st.nextToken());
            sseuns[i] = Integer.parseInt(st.nextToken());
        }
        
        if (N == 1) {
            System.out.println(Math.abs(sins[0] - sseuns[0]));
            return;
        }
        
        for(int i = 1; i < (1<<N); i++) {
            int sin = 1;
            int sseun = 0;
            for(int j = 0; j < N; j++) {
                if ((i & (1<<j)) != 0) {
                    sin *= sins[j];
                    sseun += sseuns[j];
                }
            }
            ans = Math.min(Math.abs(sin - sseun), ans);
        }
        System.out.println(ans);
    }
}