"""Run from a stable source directory and open the browser after HTTP readiness."""
from pathlib import Path
import os, sys, threading, time, urllib.request, json, webbrowser

ROOT = Path(__file__).resolve().parent
os.chdir(ROOT)
sys.path[:0] = [str(ROOT / 'src'), str(ROOT)]

for key in ['OPENBLAS_NUM_THREADS', 'OMP_NUM_THREADS', 'MKL_NUM_THREADS', 'TF_NUM_INTRAOP_THREADS', 'TF_NUM_INTEROP_THREADS']:
    os.environ.setdefault(key, '1')
os.environ.setdefault('TF_CPP_MIN_LOG_LEVEL', '2')
os.environ.setdefault('DISABLE_SQLALCHEMY_CEXT', '1')

def open_when_ready():
    print("[launch] Waiting for web server to start...", flush=True)
    for _ in range(60):
        try:
            with urllib.request.urlopen('http://127.0.0.1:8000/health', timeout=1) as r:
                if r.status in (200, 303):
                    print("[launch] Server online! Opening browser at http://127.0.0.1:8000 ...", flush=True)
                    webbrowser.open('http://127.0.0.1:8000')
                    return
        except Exception:
            try:
                with urllib.request.urlopen('http://127.0.0.1:8000/', timeout=1) as r:
                    if r.status in (200, 303):
                        print("[launch] Server online! Opening browser at http://127.0.0.1:8000 ...", flush=True)
                        webbrowser.open('http://127.0.0.1:8000')
                        return
            except Exception:
                pass
        time.sleep(0.5)

def free_port(port=8000):
    try:
        import socket, subprocess
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            if s.connect_ex(('127.0.0.1', port)) == 0:
                print(f"[launch] Port {port} in use. Cleaning up prior server instance...", flush=True)
                if sys.platform == 'win32':
                    out = subprocess.check_output(f'netstat -ano | findstr :{port}', shell=True, text=True)
                    for line in out.strip().splitlines():
                        if 'LISTENING' in line:
                            pid = line.strip().split()[-1]
                            subprocess.run(f'taskkill /F /PID {pid}', shell=True, capture_output=True)
                    time.sleep(1)
    except Exception:
        pass

if __name__ == '__main__':
    # Detect cloud / CI environment (Render sets RENDER=true automatically)
    is_cloud = bool(os.environ.get('RENDER') or os.environ.get('CI'))

    # Bind host: cloud needs 0.0.0.0; local defaults to loopback for security
    host = os.environ.get('HOST', '0.0.0.0' if is_cloud else '127.0.0.1')

    # Port: Render injects $PORT; fall back to 8000 locally
    port = int(os.environ.get('PORT', 8000))

    # Free the local port only on Windows / local runs
    if not is_cloud:
        free_port(port)

    # Open browser only for local runs where --no-browser is not passed
    if not is_cloud and '--no-browser' not in sys.argv:
        threading.Thread(target=open_when_ready, daemon=True).start()

    import uvicorn
    uvicorn.run('assurex_claim_engine.web.app:app', host=host, port=port)
