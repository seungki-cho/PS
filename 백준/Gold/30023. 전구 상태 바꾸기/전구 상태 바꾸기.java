import java.io.BufferedReader;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) throws Exception{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int N = Integer.parseInt(br.readLine());
        String line = br.readLine();
        int[][] li = new int[3][N];
        for (int i = 0; i < line.length(); i++) {
            li[0][i] = line.charAt(i) == 'R' ? 0 : (line.charAt(i) == 'G' ? 1 : 2);
        }
        li[1] = li[0].clone();
        li[2] = li[0].clone();
        int ans = Integer.MAX_VALUE;

        for (int i = 0; i < 3; i++) {
            int local = 0;
            for (int j = 0; j < N-2; j++) {
                while (li[i][j] != i) {
                    li[i][j] = (li[i][j] + 1) % 3;
                    li[i][j + 1] = (li[i][j + 1] + 1) % 3;
                    li[i][j + 2] = (li[i][j + 2] + 1) % 3;
                    local++;
                }
            }
            ans = li[i][N - 1] == i && li[i][N - 2] == i ? Math.min(ans, local) : ans;
        }
        System.out.println(ans == Integer.MAX_VALUE ? -1 : ans);
    }
}