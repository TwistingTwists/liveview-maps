defmodule LiveMapTestWeb.LiveMapAppLive do
  use LiveMapTestWeb, :live_view

  alias __MODULE__, as: LM
  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:latitude, 28.621743)
     |> assign(:longitude, 77.088269)
     |> assign(:zoom, 15)}
  end

  @impl true
  def handle_event(
        "change",
        %{"latitude" => latitude, "longitude" => longitude, "zoom" => zoom},
        socket
      ) do
    {latitude, _} = Float.parse(latitude)
    {longitude, _} = Float.parse(longitude)
    {zoom, _} = Integer.parse(zoom)

    {:noreply,
     socket
     |> assign(:latitude, latitude)
     |> assign(:longitude, longitude)
     |> assign(:zoom, zoom)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="phx-hero">
      <h1>Live Maps</h1>

      <form phx-change="change" phx-submit="change">
        <fieldset class="row">
          <label class="column">
            <input name="latitude" value={@latitude} id="latitude" />
            <span>Latitude</span>
          </label>

          <label class="column">
            <input name="longitude" value={@longitude} id="longitude" />
            <span>Longitude</span>
          </label>

          <label class="column">
            <input name="zoom" value={@zoom} id="zoom" type="number" min="0" max="18" />
            <span>Zoom</span>
          </label>
        </fieldset>

        <output name="live-map" for="latitude longitude zoom">
          <.live_component
            module={LiveMap}
            id="live-map"
            title="Example Live Map"
            width={640}
            height={360}
            latitude={@latitude}
            longitude={@longitude}
            zoom={@zoom}
          >
          </.live_component>
        </output>
      </form>
    </section>
    This is from live map app live
    """
  end
end
