defmodule MyTableWeb.TasksLive do
  @moduledoc """
  Demo 2: Boolean Filters - Tasks
  Demonstrates: boolean checkbox filters with 1,000 rows.
  """
  use MyTableWeb, :live_view
  use LiveTable.LiveResource, schema: MyTable.Life.Task

  alias LiveTable.Boolean

  def fields do
    [
      id: %{label: "ID", hidden: true},
      title: %{label: "Title", sortable: true, searchable: true},
      assigned_to: %{label: "Assigned To", searchable: true},
      due_date: %{label: "Due Date", sortable: true, renderer: &render_due_date/2},
      is_completed: %{label: "Completed", renderer: &render_boolean/1},
    ]
  end

  def filters do
    [
      completed:
        Boolean.new(:is_complete, "complete", %{
          label: "Complete",
          condition: dynamic([t], t.is_complete == true)
        }),
    ]
  end



  defp render_boolean(value) do
    assigns = %{value: value}

    ~H"""
    <span class={[
      "px-2 py-1 text-xs rounded-full",
      if(@value, do: "bg-green-100 text-green-700", else: "bg-gray-100 text-gray-600")
    ]}>
      {if @value, do: "Yes", else: "No"}
    </span>
    """
  end

  defp render_due_date(due_date, record) do
    is_overdue = Date.compare(due_date, Date.utc_today()) == :lt and not record.is_completed
    assigns = %{due_date: due_date, is_overdue: is_overdue}

    ~H"""
    <span class={[
      if(@is_overdue, do: "text-red-600 font-medium", else: "text-foreground")
    ]}>
      {Calendar.strftime(@due_date, "%d %b %Y")}
      <span :if={@is_overdue} class="text-xs">(overdue)</span>
    </span>
    """
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <Layouts.page_header
          number={2}
          title="Tasks"
          rows="1K rows"
          description="Boolean filters for completed, urgent, archived, pending, and overdue tasks."
        />

        <.live_table
          fields={fields()}
          filters={filters()}
          options={@options}
          streams={@streams}
        />
      </div>
    </Layouts.app>
    """
  end
end
