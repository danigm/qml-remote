import subprocess
import socketserver

class MyUDPHandler(socketserver.BaseRequestHandler):

    def handle(self):
        data = self.request[0].strip()
        socket = self.request[1]
        print("{} wrote:".format(self.client_address[0]))
        print(data)

        data = data.strip()
        subprocess.call(["xte", data])


if __name__ == "__main__":
    HOST, PORT = "", 8432
    server = socketserver.UDPServer((HOST, PORT), MyUDPHandler)
    server.serve_forever()
