import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

// 메모리: 13028 KB, 시간: 80 ms
public class Main {
    static int N;
    static ArrayList<Integer> arr;
    static StringBuilder sb;
    static void find(int n) {
        StringBuilder dash = new StringBuilder();
        for(int i = 0; i < n; i++) { // depth에 맞춘 _ 개수 상수 추가
            dash.append("____");
        }

        if (n == N) { // 종료조건
            sb.append(dash + "\"재귀함수가 뭔가요?\"\n");
            sb.append(dash + "\"재귀함수는 자기 자신을 호출하는 함수라네\"\n");
            sb.append(dash + "라고 답변하였지.\n");
            return;
        }

        sb.append(dash + "\"재귀함수가 뭔가요?\"\n");
        sb.append(dash + "\"잘 들어보게. 옛날옛날 한 산 꼭대기에 이세상 모든 지식을 통달한 선인이 있었어.\n");
        sb.append(dash + "마을 사람들은 모두 그 선인에게 수많은 질문을 했고, 모두 지혜롭게 대답해 주었지.\n");
        sb.append(dash + "그의 답은 대부분 옳았다고 하네. 그런데 어느 날, 그 선인에게 한 선비가 찾아와서 물었어.\"\n");

        find(n+1); // 재귀
        sb.append(dash + "라고 답변하였지.\n");
    }
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        sb = new StringBuilder();
        N = Integer.parseInt(st.nextToken());
        find(0);
        System.out.println("어느 한 컴퓨터공학과 학생이 유명한 교수님을 찾아가 물었다.");
        System.out.print(sb.toString());
    }
}