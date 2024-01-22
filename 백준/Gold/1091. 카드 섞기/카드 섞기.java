import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.StringTokenizer;

/**
 * Main
 */
public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int n = Integer.parseInt(st.nextToken());
        int[] cards = new int[n];
        int[] so = new int[n];
        st = new StringTokenizer(br.readLine());
        for(int i = 0; i < n; i++) {
            cards[i] = Integer.parseInt(st.nextToken());
        }
        st = new StringTokenizer(br.readLine());
        for(int i = 0; i < n; i++) {
            so[i] = Integer.parseInt(st.nextToken());
        }
        
        if (isSuccess(n, cards)) { System.out.println(0); return; }

        int k = 0;
        int[] init = cards.clone();

        while (true) {
            ++k;
            int[] tmp = new int[n];

            for(int i = 0; i < n; i++) {
                tmp[so[i]] = cards[i];
            }
            cards = tmp;
            if (isSuccess(n, cards)) {
                System.out.println(k);
                return;
            }
            if (Arrays.equals(init, cards)) {
                break;
            }
        }
        System.out.println(-1);
        
    }
    static boolean isSuccess(int n, int[] cards) {
        for(int i = 0; i < n; i++) {
            if (cards[i] % 3 != i % 3) {
                return false;
            }
        }
        return true;
    }
    static int customHash(int[] li) {
        return Arrays.deepHashCode(Arrays.stream(li).boxed().toArray(Integer[]::new));
    }
}