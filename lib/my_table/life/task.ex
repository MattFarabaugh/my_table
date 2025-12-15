defmodule MyTable.Life.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :title, :string
    field :description, :string
    field :assigned_to, :string
    field :is_complete, :boolean, default: false
    field :due_date, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :assigned_to, :is_complete, :due_date])
    |> validate_required([:title, :description, :assigned_to, :is_complete, :due_date])
  end
end
