const WebSocket = require('ws');

const PROXY_PORT = 8080;
const TARGET_WS_URL = 'ws://127.0.0.1:22022';   // ← Thay bằng WebSocket target của bạn

console.log(`🚀 WebSocket Proxy đang chạy tại ws://localhost:${PROXY_PORT}`);
console.log(`🔀 Forwarding đến: ${TARGET_WS_URL}`);

const wss = new WebSocket.Server({ 
    port: PROXY_PORT,
    perMessageDeflate: false 
});

wss.on('connection', (clientWs) => {
    console.log('📡 Client connected');

    // Kết nối đến WebSocket target
    const targetWs = new WebSocket(TARGET_WS_URL);

    // Chờ target kết nối xong
    targetWs.on('open', () => {
        console.log('✅ Đã kết nối đến Target WebSocket');
    });

    // Target → Client (Forward)
    targetWs.on('message', (data) => {
        if (clientWs.readyState === WebSocket.OPEN) {
            clientWs.send(data, { binary: true });
        }
    });

    // Client → Target (Forward)
    clientWs.on('message', (data) => {
        if (targetWs.readyState === WebSocket.OPEN) {
            targetWs.send(data, { binary: true });
        }
    });

    // Xử lý đóng kết nối
    const closeBoth = () => {
        clientWs.close();
        targetWs.close();
    };

    clientWs.on('close', closeBoth);
    targetWs.on('close', closeBoth);

    clientWs.on('error', (err) => {
        console.error('Client WS Error:', err.message);
        closeBoth();
    });

    targetWs.on('error', (err) => {
        console.error('Target WS Error:', err.message);
        closeBoth();
    });
});

console.log('✅ WebSocket-to-WebSocket forwarder đã sẵn sàng!');