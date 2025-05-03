async function main() {
  // 1. 1秒待つ
  await new Promise((resolve) => setTimeout(resolve, 1000));
  // 2. コンソールに出力
  console.log("Hello, wo !");
}

main().catch((error) => {
  console.error("Error in main function:", error);
});
