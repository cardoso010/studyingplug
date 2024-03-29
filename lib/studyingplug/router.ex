defmodule Studyingplug.Router do
  use Plug.Router
  use Plug.ErrorHandler

  alias Studyingplug.Plug.VerifyRequest

  plug(Plug.Parsers, parsers: [:urlenconded, :multipart])
  plug(VerifyRequest, fields: ["content", "mimetype"], paths: ["/upload"])
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Welcome!")
  end

  get "/upload" do
    send_resp(conn, 201, "Uploaded!")
  end

  match _ do
    send_resp(conn, 404, "Not Found!")
  end

  def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    IO.inspect(kind, label: :kind)
    IO.inspect(reason, label: :reason)
    IO.inspect(stack, label: :stack)
    send_resp(conn, conn.status, "Something went wrong")
  end
end
