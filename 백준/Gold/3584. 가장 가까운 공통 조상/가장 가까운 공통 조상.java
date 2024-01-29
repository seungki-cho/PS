import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st;
        int T = Integer.parseInt(br.readLine());

        
        for(int t = 0; t < T; t++) {
            int N = Integer.parseInt(br.readLine());
            int[] p = new int[N];
            for(int i = 0; i < N; i++) {
                p[i] = -1;
            }

            for(int i = 0; i < N-1; i++) {
                st = new StringTokenizer(br.readLine());
                int a = Integer.parseInt(st.nextToken())-1;
                int b = Integer.parseInt(st.nextToken())-1;
                p[b] = a;
            }
            st = new StringTokenizer(br.readLine());
            int a = Integer.parseInt(st.nextToken())-1;
            int b = Integer.parseInt(st.nextToken())-1;

            List<Integer> pa = new ArrayList<>();
            List<Integer> pb = new ArrayList<>();
            
            pa.add(a);
            pb.add(b);

            int point = a;
            while(point != -1) {
                pa.add(p[point]);
                point = p[point];
            }
            boolean flag = true; 
            for(int i = 0; i < pa.size() && flag; i++) {
                point = b;
                
                while (point != -1 && flag) {
                    if (pa.get(i) == point) {
                        System.out.println(point+1);
                        flag = false;
                    }
                    point = p[point];
                }
           }
        }
    }
}
